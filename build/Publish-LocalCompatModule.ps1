# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
	[switch]
	$Install
)

. "$psscriptroot/common-functions.ps1"

$modulePath = Join-Path (Get-ModuleBasePath) (Get-ConfigValue -Name ModuleOutputSubdirectoryName)
$modulePath = Join-Path $modulePath (Get-ModuleName)

Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if ($Install) {
	Install-Module -Name (Get-ModuleName) -Repository (Get-LocalPSRepoName) -AllowClobber
}