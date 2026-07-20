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

# PowerShellGet v2
if (Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue) {
    Write-Host 'Unregistering public PSGallery from PowerShellGet.'
    Unregister-PSRepository -Name 'PSGallery'
}
else {
    Write-Host 'PSGallery is not registered with PowerShellGet; nothing to remove.'
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
