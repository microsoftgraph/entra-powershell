# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Installs PowerShell modules used by the build, routing the download through a
    CFS (Centralized Feed Service) feed when one is configured.

.DESCRIPTION
    The 1ES CI/PR pipelines run under network isolation. The CFSClean/CFSClean2
    policies block access to the public PowerShell Gallery (powershellgallery.com)
    and require every package to be restored from a CFS-backed Azure Artifacts
    feed instead. See build/BUILD.md and https://aka.ms/1es/netiso/pipelinetemplates.

    This helper is the single place where build/test dependencies are installed so
    that the CFS wiring lives in one location:

      * Local development uses the public PowerShell Gallery (the default), so no
        extra configuration is required.
      * CI pipelines set the DEPENDENCY_PS_REPO and DEPENDENCY_PS_FEED_URL
        environment variables (and expose SYSTEM_ACCESSTOKEN) so the same modules
        are restored from the CFS feed.

    If a non-PSGallery repository is requested but no feed URL has been supplied
    (for example while the CFS feed URL is still a placeholder in a draft PR), the
    helper warns and falls back to the public PowerShell Gallery instead of
    failing the build.

.PARAMETER Name
    One or more module names to install.

.PARAMETER RequiredVersion
    Optional exact version to install.

.PARAMETER Repository
    Name of the PowerShell repository to install from. Defaults to the value of
    the DEPENDENCY_PS_REPO environment variable, or 'PSGallery' when it is unset.

.PARAMETER FeedUrl
    The v2 index URL of the CFS feed backing -Repository. Defaults to the
    DEPENDENCY_PS_FEED_URL environment variable. Only used when -Repository is not
    'PSGallery'.

.PARAMETER Token
    Access token used to authenticate to the CFS feed. Defaults to the
    SYSTEM_ACCESSTOKEN environment variable (mapped from $(System.AccessToken) in
    the pipeline).
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

# Treat a not-yet-onboarded placeholder feed URL as "no feed configured".
$feedIsPlaceholder = [string]::IsNullOrWhiteSpace($FeedUrl) -or $FeedUrl -match 'REPLACE_WITH|<.*>'

if ($Repository -ne 'PSGallery' -and $feedIsPlaceholder) {
    Write-Warning "Repository '$Repository' was requested but no CFS feed URL is configured (DEPENDENCY_PS_FEED_URL). Falling back to the public PowerShell Gallery. Set the CFS feed URL to satisfy 1ES network-isolation (CFSClean) policies."
    $Repository = 'PSGallery'
}

$credential = $null

if ($Repository -ne 'PSGallery') {
    if ($Token) {
        $securePat = ConvertTo-SecureString $Token -AsPlainText -Force
        $credential = [System.Management.Automation.PSCredential]::new('cfs', $securePat)
    }
    else {
        Write-Warning "No access token available (SYSTEM_ACCESSTOKEN); authentication to '$Repository' may fail."
    }

    # Register the CFS feed for PowerShellGet (idempotent - registration persists
    # across pipeline steps, but the credential does not, so it is always supplied
    # again at install time below).
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
