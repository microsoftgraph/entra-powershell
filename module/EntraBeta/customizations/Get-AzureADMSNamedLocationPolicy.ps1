# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSNamedLocationPolicy"
    TargetName = "Get-MgBetaIdentityConditionalAccessNamedLocation"
    Parameters = @(
        @{
            SourceName = "PolicyId"
            TargetName = "NamedLocationId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}