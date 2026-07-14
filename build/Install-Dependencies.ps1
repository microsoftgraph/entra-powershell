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

	# PowerShell repository to install dependencies from. Defaults to the public
	# PowerShell Gallery for local development. CI pipelines running under 1ES
	# network isolation set DEPENDENCY_PS_REPO to a CFS-backed feed to satisfy the
	# CFSClean/CFSClean2 policies. See build/Install-GalleryModule.ps1.
	[string]
	$Repository = $(if ($env:DEPENDENCY_PS_REPO) { $env:DEPENDENCY_PS_REPO } else { 'PSGallery' })
)

. "$psscriptroot/common-functions.ps1"

$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
if ($ModuleSettingsPath) { $settingPath = $ModuleSettingsPath }
$content = Get-Content -Path $settingPath | ConvertFrom-Json

# The AzureAD and AzureADPreview modules have been deprecated and removed from
# PowerShell Gallery. The source module is no longer installed as a dependency.
# Command lists are now derived from the static mapping files instead.
Write-Verbose("Skipping deprecated source module '$($content.sourceModule)' - no longer available on PowerShell Gallery")

foreach ($moduleName in $content.destinationModuleName){
    Write-Verbose("Installing Module $($moduleName)")
    & "$PSScriptRoot/Install-GalleryModule.ps1" -Name $moduleName -RequiredVersion $content.destinationModuleVersion -Repository $Repository -AllowClobber
}