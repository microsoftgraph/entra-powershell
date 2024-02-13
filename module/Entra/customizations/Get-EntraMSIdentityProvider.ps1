# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSIdentityProvider"
    TargetName = "Get-MgIdentityProvider"
    Parameters = $null
    Outputs = @(
        @{
            SourceName = "AdditionalProperties"
            TargetName = "AdditionalProperties"
            ConversionType = "FlatObject"
            SpecialMapping = $null
        }
        @{
            SourceName = "DisplayName"
            TargetName = "Name"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "identityProviderType"
            TargetName = "Type"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
}