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

Uninstall-Module -Name Microsoft.Graph.Authentication -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.DirectoryObjects -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Users -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Users.Actions -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Users.Functions -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Groups -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Identity.DirectoryManagement -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Identity.Governance -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Identity.SignIns -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Applications -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Reports -Force -Verbose

Uninstall-Module -Name Microsoft.Graph.Beta.Users -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Users.Actions -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Users.Functions -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Groups -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Identity.DirectoryManagement -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Identity.Governance -Force -Verbose 
Uninstall-Module -Name Microsoft.Graph.Beta.Identity.SignIns -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Applications -Force -Verbose
Uninstall-Module -Name Microsoft.Graph.Beta.Reports Force -Verbose

if($moduleName -eq 'Entra'){
	Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

foreach ($destinationModuleName in $content.destinationModuleName){
	Publish-Module -Name $destinationModuleName -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

foreach($module in $fullModuleNames){
	if(($module -eq 'Microsoft.Entra') -or ($module -eq 'Microsoft.Entra.Beta')){
		continue
	}
	$modulePath = Join-Path (Get-ModuleBasePath) (Get-ConfigValue -Name ModuleOutputSubdirectoryName)
	$modulePath = Join-Path $modulePath $module
	Log-Message "[Publish Local Compat] module : $module" -Level 'INFO'
	Log-Message "[Publish Local Compat] modulePath : $modulePath" -Level 'INFO'
	Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

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
