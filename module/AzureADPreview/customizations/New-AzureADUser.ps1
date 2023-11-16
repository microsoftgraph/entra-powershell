# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADUser"
    TargetName = "New-MgBetaUser"
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
        },
        @{
            SourceName = "ImmutableId"
            TargetName = "OnPremisesImmutableId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "Mobile"
            TargetName = "MobilePhone"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "SignInNames"
            TargetName = "Identities"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "TelephoneNumber"
            TargetName = "BusinessPhones"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "UserState"
            TargetName = "ExternalUserState"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "UserStateChangedOn"
            TargetName = "ExternalUserStateChangeDateTime"
            ConversionType = "Name"
            SpecialMapping = $null
        }

    )
    Outputs = $null
}