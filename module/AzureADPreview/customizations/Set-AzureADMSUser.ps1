# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSUser"
    TargetName = "Update-MgBetaUser"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "UserId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "DisplayName"
            TargetName = "DisplayName"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "CustomSecurityAttributes"
            TargetName = "CustomSecurityAttributes"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "UserPrincipalName"
            TargetName = "UserPrincipalName"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}