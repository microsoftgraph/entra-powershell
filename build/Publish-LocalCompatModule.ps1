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

Publish-Module -Name Microsoft.Graph.Authentication -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.DirectoryObjects -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Users -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Users.Actions -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Users.Functions -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Groups -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Identity.DirectoryManagement -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Identity.Governance -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Identity.SignIns -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName)
Publish-Module -Name Microsoft.Graph.Application -RequiredVersion '2.15.0' -Repository (Get-LocalPSRepoName) -Force

Publish-Module -Path $modulePath -Repository (Get-LocalPSRepoName)

if ($Install) {
	Install-Module -Name (Get-ModuleName) -Repository (Get-LocalPSRepoName) -AllowClobber

	Install-Module -Name Microsoft.Graph.DirectoryObjects -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Users -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Users.Actions -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Users.Functions -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Groups -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Identity.DirectoryManagement -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Identity.Governance -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Identity.SignIns -Repository (Get-LocalPSRepoName) -AllowClobber
	Install-Module -Name Microsoft.Graph.Application -Repository (Get-LocalPSRepoName) -AllowClobber
}