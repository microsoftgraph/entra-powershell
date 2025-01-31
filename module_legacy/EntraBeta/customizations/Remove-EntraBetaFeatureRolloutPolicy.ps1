# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSFeatureRolloutPolicy"
    TargetName = "Remove-MgBetaPolicyFeatureRolloutPolicy"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "FeatureRolloutPolicyId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}