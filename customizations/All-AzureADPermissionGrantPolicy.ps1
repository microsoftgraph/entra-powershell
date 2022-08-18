# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param()


$cmdlets = @()
$cmdlets += [CmdletMap]::New("Set-AzureADMSPermissionGrantPolicy","Update-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CmdletMap]::New("Remove-AzureADMSPermissionGrantPolicy","Remove-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CmdletMap]::New("Get-AzureADMSPermissionGrantPolicy","Get-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CmdletMap]::New("New-AzureADMSPermissionGrantPolicy","New-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets

