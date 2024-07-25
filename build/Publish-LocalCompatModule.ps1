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
$fullModuleName = Get-ModuleName
if($fullModuleName -eq 'Microsoft.Graph.Entra'){
	$moduleName = 'Entra'
}
else{
	$moduleName = 'EntraBeta'
}

$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
$content = Get-Content -Path $settingPath | ConvertFrom-Json

if($moduleName -eq 'Entra'){
	Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

foreach ($destinationModuleName in $content.destinationModuleName){
    Write-Verbose("Publishing Module $($destinationModuleName)")
	Publish-Module -Name $destinationModuleName -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if ($Install) {
	Install-Module -Name (Get-ModuleName) -Repository (Get-LocalPSRepoName) -AllowClobber
}