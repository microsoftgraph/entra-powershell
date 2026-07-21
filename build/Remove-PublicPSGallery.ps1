# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Removes the public PowerShell Gallery from the build agent under network isolation.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation, where the CFSClean2 SFI
    policy flags any connection to www.powershellgallery.com. Even though every
    Install-Module / Publish-Module in the build targets the CFS-backed feed
    (or the build's local gallery) via -Repository, PowerShellGet still probes the
    default 'PSGallery' source while resolving package sources and module
    dependencies (e.g. the Microsoft.Graph.* RequiredModules check during
    Publish-Module). Those probes are the residual CFSClean2 violations.

    Unregistering PSGallery from both PowerShellGet and PSResourceGet leaves the
    feed and the local gallery as the only sources, so no PowerShell step can reach
    the public gallery. The change persists on the agent for the rest of the job.

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
