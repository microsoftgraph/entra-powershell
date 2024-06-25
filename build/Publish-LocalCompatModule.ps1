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
# $moduleName = $moduleName.TrimStart("Microsoft.Graph.");
# $moduleName = $moduleName.Trim(".","");
$settingPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
$content = Get-Content -Path $settingPath | ConvertFrom-Json

if($moduleName -eq 'Entra'){
	Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

foreach ($destinationModuleName in $content.destinationModuleName){
    Write-Verbose("Publishing Module $($destinationModuleName)")
	Publish-Module -Name $destinationModuleName -RequiredVersion $content.destinationModuleVersion -Repository (Get-LocalPSRepoName)
}

# Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.DirectoryObjects -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Users -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Users.Actions -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Users.Functions -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Groups -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Identity.DirectoryManagement -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Identity.Governance -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Identity.SignIns -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
# Publish-Module -Name Microsoft.Graph.Applications -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)

Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if ($Install) {
	Install-Module -Name (Get-ModuleName) -Repository (Get-LocalPSRepoName) -AllowClobber

	# foreach ($destinationModuleName in $content.destinationModuleName){
	# 	Write-Verbose("Installing Module $($destinationModuleName)")
	# 	Publish-Module $destinationModuleName -scope currentuser -RequiredVersion $content.destinationModuleVersion -Force -AllowClobber
	# }

	# Install-Module -Name Microsoft.Graph.DirectoryObjects -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Users -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Users.Actions -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Users.Functions -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Groups -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Identity.DirectoryManagement -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Identity.Governance -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Identity.SignIns -Repository (Get-LocalPSRepoName) -AllowClobber
	# Install-Module -Name Microsoft.Graph.Applications -Repository (Get-LocalPSRepoName) -AllowClobber
}