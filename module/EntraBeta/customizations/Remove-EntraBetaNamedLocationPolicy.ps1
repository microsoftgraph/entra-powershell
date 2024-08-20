# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSNamedLocationPolicy"
    TargetName = "Remove-MgBetaIdentityConditionalAccessNamedLocation"
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