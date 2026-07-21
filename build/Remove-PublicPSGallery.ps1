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
    Those come from the hard-coded default gallery endpoint baked into the
    PowerShellGet / PSResourceGet module stack (used opportunistically while
    resolving module metadata), which cannot be removed by repository management.

    To make the build genuinely never reach the public gallery, this script also
    null-routes www.powershellgallery.com in the agent hosts file for the duration
    of the job. Because every dependency is installed from the private feed, these
    probes are non-essential, so resolving the host locally to 0.0.0.0 is safe and
    eliminates the CFSClean2 violations for the PR, CI and release pipelines.

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

# Null-route the public gallery host. Repository management alone does not stop the
# hard-coded default gallery endpoint in the PowerShellGet / PSResourceGet stack, so
# resolve www.powershellgallery.com to a dead address locally. The DNS lookup is then
# satisfied by the hosts file (no query leaves the agent) and any stray connection
# goes to 0.0.0.0, so the CFSClean2 policy records no connection to the domain.
$galleryHosts = @('www.powershellgallery.com', 'psg-prod-eastus.azureedge.net')
$hostsPath = if ($IsWindows -or $env:OS -eq 'Windows_NT') {
    Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'
}
else {
    '/etc/hosts'
}

Write-Host "Null-routing public gallery hosts via '$hostsPath'."
try {
    if (-not (Test-Path $hostsPath)) {
        New-Item -Path $hostsPath -ItemType File -Force | Out-Null
    }

    $existing = Get-Content -Path $hostsPath -ErrorAction SilentlyContinue
    $newLines = New-Object System.Collections.Generic.List[string]
    foreach ($galleryHost in $galleryHosts) {
        if ($existing -match ("(?i)\s" + [regex]::Escape($galleryHost) + "\s*$")) {
            Write-Host "  $galleryHost already present in hosts file."
        }
        else {
            $newLines.Add("0.0.0.0`t$galleryHost")
        }
    }

    if ($newLines.Count -gt 0) {
        Add-Content -Path $hostsPath -Value $newLines -ErrorAction Stop
        $newLines | ForEach-Object { Write-Host "  Added: $_" }
    }

    # Best-effort: clear any cached DNS entry so the hosts file takes effect immediately.
    if (Get-Command -Name 'Clear-DnsClientCache' -ErrorAction SilentlyContinue) {
        Clear-DnsClientCache -ErrorAction SilentlyContinue
    }
}
catch {
    Write-Host "  (Unable to update hosts file: $($_.Exception.Message))"
}
