# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADUser"
    TargetName = "New-MgUser"
    Parameters = @(
        @{
            SourceName = "PasswordProfile"
            TargetName = "PasswordProfile"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = @{
            forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
            password = `$TmpValue.Password 
        }
"@
        }
    )
    Outputs = $null
}