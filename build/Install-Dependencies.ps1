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
	$ModuleSettingsPath,

	# Force installation of required modules, even if they are already installed.
	[switch]
	$Force
)

. "$psscriptroot/common-functions.ps1"

$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
if ($ModuleSettingsPath) { $settingPath = $ModuleSettingsPath }
$content = Get-Content -Path $settingPath | ConvertFrom-Json

if ($Force) {
	Write-Verbose 'Skipping the check for installed prerequisites.'
} else {
	Write-Verbose 'Checking installed modules for required dependencies.'
	$InstalledModules = Get-Module -ListAvailable -Verbose:$false | Group-Object -Property Name
}

$SourceModule = $content.sourceModule
if (($InstalledModules.Name -contains $SourceModule) -and -not $Force) {
	Write-Verbose "The $SourceModule module is already installed."
} else {
	Write-Verbose("Installing Module: $sourceModule")
	Install-Module $sourceModule -Scope CurrentUser -Force -AllowClobber
}

foreach ($moduleName in $content.destinationModuleName) {
	$InstalledModuleReference = $InstalledModules.Where({ $_.Name -eq $moduleName }).Group
	if (($InstalledModuleReference.Version -ge $content.destinationModuleVersion) -and -not $Force) {
		Write-Verbose "The $moduleName module is already installed."
	} else {
		Write-Verbose "Installing Module: $moduleName"
		Install-Module $moduleName -Scope CurrentUser -RequiredVersion $content.destinationModuleVersion -Force -AllowClobber
	}
}
