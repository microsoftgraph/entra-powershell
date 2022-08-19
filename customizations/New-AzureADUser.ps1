# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param()

$cmdlets = @()
$param = @{}
$script = @"
`$Value = @{
            forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
            password = `$TmpValue.Password 
        }
"@
$param.Add("PasswordProfile", [DataMap]::New("PasswordProfile", "PasswordProfile", 99, [Scriptblock]::Create($script)))
$cmdlets += [CmdletMap]::New("New-AzureADUser","New-MgUser", $param, $null)
$cmdlets