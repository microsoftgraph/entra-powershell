# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
	[ArgumentCompleter({ (Get-ChildItem -Path "$PSScriptRoot\..\module").Name })]
	[string]
	$ModuleName = 'Entra',

	[ValidateScript({ Test-Path $_ })]
	[string]
    $ModuleSettingsPath
)

. "$psscriptroot/common-functions.ps1"

$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
if ($ModuleSettingsPath) { $settingPath = $ModuleSettingsPath }
$content = Get-Content -Path $settingPath | ConvertFrom-Json
Write-Verbose("Installing Module $($content.sourceModule)")
Install-Module $content.sourceModule -scope currentuser -Force -AllowClobber
$installedModule = Get-Module -Name $content.sourceModule -ListAvailable | Select-Object -First 1
Write-Host "Installed Module: $($content.sourceModule) - version: $($installedModule.Version)" -ForegroundColor Green

foreach ($moduleName in $content.destinationModuleName){
    Write-Verbose("Installing Module $($moduleName)")
    Install-Module $moduleName -scope currentuser -RequiredVersion $content.destinationModuleVersion -Force -AllowClobber
    $installedModule = Get-Module -Name $moduleName -ListAvailable | Select-Object -First 1
    Write-Host "-> Installed Module: $($moduleName) - version: $($installedModule.Version)" -ForegroundColor Green
}