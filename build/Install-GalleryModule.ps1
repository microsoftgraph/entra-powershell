# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Installs build/test dependencies, from a private feed when one is configured.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation (CFSClean/CFSClean2), which
    blocks the public PowerShell Gallery. Those pipelines run NuGetAuthenticate and
    set DEPENDENCY_PS_REPO / DEPENDENCY_PS_FEED_URL so modules (and their transitive
    dependencies) are restored from that feed; the Azure Artifacts credential
    provider handles authentication. Local development uses the public PowerShell
    Gallery by default. See https://aka.ms/1es/netiso/pipelinetemplates.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]] $Name,

    [string] $RequiredVersion,

    [string] $Repository = $(if ($env:DEPENDENCY_PS_REPO) { $env:DEPENDENCY_PS_REPO } else { 'PSGallery' }),

    [string] $FeedUrl = $env:DEPENDENCY_PS_FEED_URL,

    [switch] $SkipPublisherCheck,

    [switch] $AllowClobber
)

$ErrorActionPreference = 'Stop'

if ($Repository -ne 'PSGallery') {
    if (-not $FeedUrl) {
        throw "Repository '$Repository' requires a feed URL. Set DEPENDENCY_PS_FEED_URL (or pass -FeedUrl)."
    }

    if (-not (Get-PSRepository -Name $Repository -ErrorAction SilentlyContinue)) {
        Write-Verbose "Registering PSRepository '$Repository' -> $FeedUrl"
        Register-PSRepository -Name $Repository -SourceLocation $FeedUrl -InstallationPolicy Trusted
    }
}

foreach ($module in $Name) {
    Write-Verbose "Installing module '$module' from repository '$Repository'"
    $install = @{
        Name       = $module
        Repository = $Repository
        Scope      = 'CurrentUser'
        Force      = $true
    }
    if ($RequiredVersion)    { $install['RequiredVersion']    = $RequiredVersion }
    if ($SkipPublisherCheck) { $install['SkipPublisherCheck'] = $true }
    if ($AllowClobber)       { $install['AllowClobber']       = $true }

    Install-Module @install
}
