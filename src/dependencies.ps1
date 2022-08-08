# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

. (join-path $psscriptroot DataMap.ps1)
. (join-path $psscriptroot CmdletMap.ps1)
. (join-path $psscriptroot CmdletTranslation.ps1)
. (join-path $psscriptroot ModuleMap.ps1)
. (join-path $psscriptroot cmdletMapper.ps1)

$map = [CmdletMapper]::new()
$map.AddCustomizationsFile("C:\Src\Microsoft.Graph.Compatibility.AzureAD\TestInput.json")
$map.AddCustomization("Set-AzureADMSPermissionGrantPolicy","Update-MgPolicyPermissionGrantPolicy", $null, $null)
$map.AddCustomization("Remove-AzureADMSPermissionGrantPolicy","Remove-MgPolicyPermissionGrantPolicy", $null, $null)
$param = @{}
$script = @"
`$Value = @{
    forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
    password = `$TmpValue.Password 
}
"@
$param.Add("PasswordProfile", [DataMap]::New("PasswordProfile", "PasswordProfile", 99, [Scriptblock]::Create($script)))
$map.AddCustomization("New-AzureADUser","New-MgUser", $param, $null)
$map.GenerateInputDataFile()
Write-Host "Done!"
