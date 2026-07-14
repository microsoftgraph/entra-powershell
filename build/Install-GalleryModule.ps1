# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Installs build/test dependencies, from a private feed when one is configured.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation (CFSClean/CFSClean2), which
    blocks the public PowerShell Gallery, so modules are restored from a CFS-backed
    Azure Artifacts feed instead. Authenticating to that feed requires BOTH:

      * -Credential (built from SYSTEM_ACCESSTOKEN): PowerShellGet uses this to
        authenticate its own requests for the requested (top-level) modules.
      * The Azure Artifacts credential provider (set up by the pipeline's
        NuGetAuthenticate task): PowerShellGet does NOT propagate -Credential to
        transitive dependency installs, so those requests authenticate through the
        credential provider instead.

    Local development uses the public PowerShell Gallery by default (no feed, no
    token). See https://aka.ms/1es/netiso/pipelinetemplates.
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '',
    Justification = 'The pipeline access token is only available as plain text (SYSTEM_ACCESSTOKEN) and must be wrapped in a PSCredential to authenticate to the private feed.')]
[CmdletBinding()]
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
    if (-not $Token) {
        throw "Repository '$Repository' requires an access token. Set SYSTEM_ACCESSTOKEN (or pass -Token)."
    }

    $securePassword = ConvertTo-SecureString $Token -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential('AzureDevOps', $securePassword)

    if (-not (Get-PSRepository -Name $Repository -ErrorAction SilentlyContinue)) {
        Write-Verbose "Registering PSRepository '$Repository' -> $FeedUrl"
        Register-PSRepository -Name $Repository -SourceLocation $FeedUrl -InstallationPolicy Trusted -Credential $credential
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
