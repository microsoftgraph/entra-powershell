# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
	[switch]
	$Install
)

. "$psscriptroot/common-functions.ps1"

$fullModuleNames = @()
$modName = Get-ModuleName

if($modName -is [array]){
	$fullModuleName = $modName[0]
	$fullModuleNames = $modName
}
else{
	$fullModuleName = $modName
	$fullModuleNames += $modName
}

if($fullModuleName -like 'Microsoft.Entra.Beta*'){
	$moduleName = 'EntraBeta'
}
else{
	$moduleName = 'Entra'
}

$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
$content = Get-Content -Path $settingPath | ConvertFrom-Json
$metadataPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleMetadata.json"
$metadata = Get-Content -Path $metadataPath | ConvertFrom-Json

foreach ($destinationModuleName in $content.destinationModuleName){
	if(Get-Module -ListAvailable -Name $destinationModuleName){
          Uninstall-Module -Name $destinationModuleName -Force -Verbose
	}
}

if($moduleName -eq 'Entra'){
	   Uninstall-Module -Name Microsoft.Graph.Authentication -Force -Verbose
       Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName) -Force -Verbose
}

foreach ($destinationModuleName in $content.destinationModuleName){
       Publish-Module -Name $destinationModuleName -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName) -Force -Verbose
}

foreach($module in $fullModuleNames){
	if(($module -eq 'Microsoft.Entra') -or ($module -eq 'Microsoft.Entra.Beta')){
		continue
	}
	$modulePath = Join-Path (Get-ModuleBasePath) (Get-ConfigValue -Name ModuleOutputSubdirectoryName)
	$modulePath = Join-Path $modulePath $module
	Log-Message "[Publish Local Compat] module : $module" -Level 'INFO'
	Log-Message "[Publish Local Compat] modulePath : $modulePath" -Level 'INFO'

	Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName) -Force -Verbose

	if ($Install) {
		Log-Message "[Publish Local Compat] Installing : $module" -Level 'INFO'
		Install-Module -Name $module -Repository (Get-LocalPSRepoName) -AllowClobber
	}
}

if($moduleName -eq 'Entra'){
	$module = 'Microsoft.Entra'
}
else{
	$module = 'Microsoft.Entra.Beta'
}

$modulePath = Join-Path (Get-ModuleBasePath) (Get-ConfigValue -Name ModuleOutputSubdirectoryName)
$modulePath = Join-Path $modulePath $module
$modulePath = Join-Path $modulePath $metadata.version
Log-Message "[Publish Local Compat] module : $module" -Level 'INFO'
Log-Message "[Publish Local Compat] modulePath : $modulePath" -Level 'INFO'
Publish-PSResource -Path $modulePath -Repository (Get-LocalPSRepoName) -SkipDependenciesCheck

if ($Install) {
	Log-Message "[Publish Local Compat] Installing : $module" -Level 'INFO'
	Install-Module -Name $module -Repository (Get-LocalPSRepoName) -AllowClobber
}
