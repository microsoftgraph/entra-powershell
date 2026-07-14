# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Installs build/test dependencies, from a private feed when one is configured.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation (CFSClean/CFSClean2), which
    blocks the public PowerShell Gallery. Pipelines set DEPENDENCY_PS_REPO and
    DEPENDENCY_PS_FEED_URL (and expose SYSTEM_ACCESSTOKEN) so modules are restored
    from that feed; local development uses the public PowerShell Gallery by default.
    See https://aka.ms/1es/netiso/pipelinetemplates.
#>
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Justification = 'The pipeline access token is only available as plain text and must be converted to a SecureString to build a PSCredential for the CFS feed.')]
param(
    [Parameter(Mandatory)]
    [string[]] $Name,

    [string] $RequiredVersion,

    [string] $Repository = $(if ($env:DEPENDENCY_PS_REPO) { $env:DEPENDENCY_PS_REPO } else { 'PSGallery' }),

    [string] $FeedUrl = $env:DEPENDENCY_PS_FEED_URL,

    [string] $Token = $env:SYSTEM_ACCESSTOKEN,

    [switch] $SkipPublisherCheck,

    [switch] $AllowClobber
)

$ErrorActionPreference = 'Stop'

$credential = $null

if ($Repository -ne 'PSGallery') {
    if (-not $FeedUrl) {
        throw "Repository '$Repository' requires a feed URL. Set DEPENDENCY_PS_FEED_URL (or pass -FeedUrl)."
    }

    if ($Token) {
        $securePat = ConvertTo-SecureString $Token -AsPlainText -Force
        $credential = [System.Management.Automation.PSCredential]::new('cfs', $securePat)
    }

    # Registration persists across pipeline steps but the credential does not, so
    # the feed is registered once here and the credential is supplied again at
    # install time below.
    if (-not (Get-PSRepository -Name $Repository -ErrorAction SilentlyContinue)) {
        Write-Verbose "Registering PSRepository '$Repository' -> $FeedUrl"
        $register = @{
            Name               = $Repository
            SourceLocation     = $FeedUrl
            InstallationPolicy = 'Trusted'
        }
        if ($credential) { $register['Credential'] = $credential }
        Register-PSRepository @register
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
    if ($credential)         { $install['Credential']         = $credential }

    Install-Module @install
}
