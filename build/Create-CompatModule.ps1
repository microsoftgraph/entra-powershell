# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param($targetDirectory = $null, [switch] $noclean)

. (join-path $psscriptroot "/common-functions.ps1")
. (join-path $psscriptroot "../src/dependencies.ps1")

Remove-BuildDirectories
$outputFolder = join-path $psscriptroot "../bin"
$nocleanArgument = @{noclean=$noclean}
$map = [CmdletMapper]::new($outputFolder)
$map.AddCustomization("Set-AzureADMSPermissionGrantPolicy","Update-MgPolicyPermissionGrantPolicy", $null, $null)
$map.AddCustomization("Remove-AzureADMSPermissionGrantPolicy","Remove-MgPolicyPermissionGrantPolicy", $null, $null)
$param = @{}
$outputs = @{}
$script = @"
`$Value = @{
    forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
    password = `$TmpValue.Password 
}
"@
$scriptOutput = "`$Value = {`$this.ToUpper()}"
$param.Add("PasswordProfile", [DataMap]::New("PasswordProfile", "PasswordProfile", 99, [Scriptblock]::Create($script)))
$outputs.Add("DisplayName",[DataMap]::New("DisplayName","ObjectIdTest", 2, $null))
$outputs.Add("Id",[DataMap]::New("Id","TestScript", 99, [Scriptblock]::Create($scriptOutput)))
$map.AddCustomization("New-AzureADUser","New-MgUser", $param, $outputs)
$map.GenerateModuleFiles()
Move-ModuleFiles -OutputDirector $targetDirectory @nocleanArgument

