# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

$cmdlets = @()
$cmdlets += [CommandMap]::New("Set-AzureADMSPermissionGrantPolicy","Update-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CommandMap]::New("Remove-AzureADMSPermissionGrantPolicy","Remove-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CommandMap]::New("Get-AzureADMSPermissionGrantPolicy","Get-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets += [CommandMap]::New("New-AzureADMSPermissionGrantPolicy","New-MgPolicyPermissionGrantPolicy", $null, $null)
$cmdlets

