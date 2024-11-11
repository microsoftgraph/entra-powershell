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

if($fullModuleName -like 'Microsoft.Graph.Entra.Beta*'){
	$moduleName = 'EntraBeta'
}
else{
	$moduleName = 'Entra'
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

foreach($module in $fullModuleNames){
	if(($module -eq 'Microsoft.Graph.Entra') -or ($module -eq 'Microsoft.Graph.Entra.Beta')){
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

foreach($module in $fullModuleNames){
	if(($module -eq 'Microsoft.Graph.Entra') -or ($module -eq 'Microsoft.Graph.Entra.Beta')){
		continue
	}
	Import-Module $module -Verbose
}

if($moduleName -eq 'Entra'){
	$module = 'Microsoft.Graph.Entra'
}
else{
	$module = 'Microsoft.Graph.Entra.Beta'
}

$modulePath = Join-Path (Get-ModuleBasePath) (Get-ConfigValue -Name ModuleOutputSubdirectoryName)
$modulePath = Join-Path $modulePath $module
Log-Message "[Publish Local Compat] module : $module" -Level 'INFO'
Log-Message "[Publish Local Compat] modulePath : $modulePath" -Level 'INFO'
$available = Get-Module -ListAvailable
$pathenv = $env:PSModulePath
Log-Message "[Publish Local Compat] Available : $available" -Level 'INFO'
Log-Message "[Publish Local Compat] pathenv : $pathenv" -Level 'INFO'
Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if ($Install) {
	Log-Message "[Publish Local Compat] Installing : $module" -Level 'INFO'
	Install-Module -Name $module -Repository (Get-LocalPSRepoName) -AllowClobber
}

