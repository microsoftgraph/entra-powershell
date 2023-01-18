# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
    [string] $TargetDirectory = $null,
    [switch] $Install
    )

. "$psscriptroot/common-functions.ps1"

Register-LocalGallery -Path $TargetDirectory

$modulePath = Join-Path (Get-ModuleBasePath) $moduleOutputSubdirectory
$modulePath = Join-Path $modulePath (Get-ModuleName)

Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if($Install.IsPresent){
    Install-Module -Name (Get-ModuleName) -Repository (Get-LocalPSRepoName) -AllowClobber
}