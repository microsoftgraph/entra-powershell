# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Hardens the build agent against the public PowerShell Gallery under network isolation.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation, where the CFSClean2 SFI
    policy flags any connection to www.powershellgallery.com. Every Install-Module /
    Publish-Module in the build already targets the CFS-backed feed (or the build's
    local gallery) via -Repository, and this script also unregisters the public
    PSGallery from PowerShellGet, PackageManagement and PSResourceGet.

    However, the residual CFSClean2 violations are NOT caused by a registered
    PSGallery source: an instrumented run proved that after unregistering PSGallery
    from every subsystem, pwsh still opened 3 connections to www.powershellgallery.com.
    Those come from a hard-coded default gallery endpoint baked into the
    PowerShellGet / PSResourceGet module stack, which cannot be removed by repository
    management, and cannot be hidden with a hosts-file null-route because the 1ES
    netiso HostsFileStabilizer manages the hosts file and records the DNS query name
    regardless of how it resolves.

    To attribute the residual connections to a specific build step, this script also
    enables Windows Filtering Platform (WFP) connection auditing immediately after
    network isolation starts. Report-GalleryNetwork.ps1 then dumps every blocked
    outbound connection (process, PID, destination address/port, timestamp) at the
    end of the job, so the connection timestamps can be correlated against the
    pipeline timeline to pinpoint the offending step. DNS-layer logging cannot be
    used because netiso's HostsFileStabilizer pre-populates the gallery hostname in
    the hosts file, so the name resolves with no DNS query while the blocked TCP
    connection still fires.

    Local development is unaffected: this only acts when the pipeline configures a
    private dependency repository (DEPENDENCY_PS_REPO set to something other than
    'PSGallery'), so running it on a developer machine is a no-op.

    See https://aka.ms/1es/netiso/pipelinetemplates.
#>
[CmdletBinding()]
param(
    [string] $Repository = $env:DEPENDENCY_PS_REPO
)

$ErrorActionPreference = 'Stop'

if (-not $Repository -or $Repository -eq 'PSGallery') {
    Write-Host 'No private dependency repository configured (DEPENDENCY_PS_REPO); leaving PSGallery registered.'
    return
}

function Write-SourceInventory {
    param([string] $Label)

    Write-Host "===== Package source inventory ($Label) ====="

    Write-Host '--- PowerShellGet PSRepositories ---'
    try { Get-PSRepository -ErrorAction Stop | Format-Table Name, SourceLocation, InstallationPolicy -AutoSize | Out-String | Write-Host }
    catch { Write-Host "  (Get-PSRepository failed: $($_.Exception.Message))" }

    Write-Host '--- PackageManagement sources ---'
    try { Get-PackageSource -ErrorAction Stop | Format-Table Name, ProviderName, Location, IsTrusted -AutoSize | Out-String | Write-Host }
    catch { Write-Host "  (Get-PackageSource failed: $($_.Exception.Message))" }

    if (Get-Command -Name 'Get-PSResourceRepository' -ErrorAction SilentlyContinue) {
        Write-Host '--- PSResourceGet repositories ---'
        try { Get-PSResourceRepository -ErrorAction Stop | Format-Table Name, Uri, Trusted -AutoSize | Out-String | Write-Host }
        catch { Write-Host "  (Get-PSResourceRepository failed: $($_.Exception.Message))" }
    }

    # NuGet.config files that the NuGet client / credential provider read. A
    # powershellgallery source configured here would be probed by pwsh outside of
    # the PowerShellGet repository store.
    Write-Host '--- NuGet.config files referencing powershellgallery ---'
    $configPaths = @(
        (Join-Path $env:APPDATA 'NuGet\NuGet.Config'),
        (Join-Path $env:ProgramData 'NuGet\NuGet.Config'),
        (Join-Path ${env:ProgramFiles(x86)} 'NuGet\Config')
    ) | Where-Object { $_ -and (Test-Path $_) }
    $found = $false
    foreach ($p in $configPaths) {
        $files = @()
        if (Test-Path $p -PathType Container) {
            $files = Get-ChildItem -Path $p -Filter '*.config' -File -Recurse -ErrorAction SilentlyContinue
        }
        elseif (Test-Path $p -PathType Leaf) {
            $files = Get-Item -Path $p -ErrorAction SilentlyContinue
        }
        foreach ($f in $files) {
            if (Select-String -Path $f.FullName -Pattern 'powershellgallery' -SimpleMatch -ErrorAction SilentlyContinue) {
                Write-Host "  $($f.FullName) references powershellgallery"
                $found = $true
            }
        }
    }
    if (-not $found) { Write-Host '  (none)' }

    Write-Host "===== End inventory ($Label) ====="
}

Write-SourceInventory -Label 'before'

# PowerShellGet v2
if (Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue) {
    Write-Host 'Unregistering public PSGallery from PowerShellGet.'
    Unregister-PSRepository -Name 'PSGallery'
}
else {
    Write-Host 'PSGallery is not registered with PowerShellGet; nothing to remove.'
}

# PackageManagement / OneGet: Install-Module ultimately resolves through the
# PackageManagement source list, which can retain a powershellgallery-backed
# source even after the PowerShellGet PSRepository is unregistered.
if (Get-Command -Name 'Get-PackageSource' -ErrorAction SilentlyContinue) {
    $publicSources = Get-PackageSource -ErrorAction SilentlyContinue |
        Where-Object { $_.Location -and $_.Location -match 'powershellgallery\.com' }
    foreach ($source in $publicSources) {
        Write-Host "Unregistering PackageManagement source '$($source.Name)' ($($source.Location))."
        try { Unregister-PackageSource -Name $source.Name -Force -ErrorAction Stop }
        catch { Write-Host "  (Unregister-PackageSource failed: $($_.Exception.Message))" }
    }
    if (-not $publicSources) {
        Write-Host 'No powershellgallery-backed PackageManagement sources registered; nothing to remove.'
    }
}

# PSResourceGet (v3)
if (Get-Command -Name 'Get-PSResourceRepository' -ErrorAction SilentlyContinue) {
    if (Get-PSResourceRepository -Name 'PSGallery' -ErrorAction SilentlyContinue) {
        Write-Host 'Unregistering public PSGallery from PSResourceGet.'
        Unregister-PSResourceRepository -Name 'PSGallery'
    }
    else {
        Write-Host 'PSGallery is not registered with PSResourceGet; nothing to remove.'
    }
}

Write-SourceInventory -Label 'after'

# The residual CFSClean2 violations are NOT caused by a registered PSGallery source
# (proven: they persist after every source above is removed). DNS-layer attribution
# also fails, because the 1ES netiso HostsFileStabilizer pre-populates
# www.powershellgallery.com in the hosts file: the name resolves from hosts with NO
# DNS query (nothing in the DNS-Client Operational log), yet the outbound TCP
# connection to the gallery IP still fires and trips the WFP violation. The reliable
# attribution source is Windows Filtering Platform connection auditing: a blocked
# egress produces Security event 5157 with the process image, PID, destination
# address/port and timestamp. Enable it here (right after isolation starts);
# Report-GalleryDns.ps1 dumps the matching blocked connections at the end of the job
# so their timestamps can be correlated against the pipeline timeline.
Write-Host 'Enabling Windows Filtering Platform connection auditing for gallery-connection attribution.'
try {
    & auditpol.exe /set /subcategory:'Filtering Platform Connection' /success:enable /failure:enable | Out-Null
    & auditpol.exe /set /subcategory:'Filtering Platform Packet Drop' /success:enable /failure:enable | Out-Null
    Write-Host '  WFP connection/packet-drop auditing enabled (Security events 5157/5152).'
}
catch {
    Write-Host "  (Unable to enable WFP auditing: $($_.Exception.Message))"
}
