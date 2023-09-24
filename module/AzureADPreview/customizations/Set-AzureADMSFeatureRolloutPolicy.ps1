# -----------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# -----------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSFeatureRolloutPolicy"
    TargetName = "Update-MgBetaPolicyFeatureRolloutPolicy"
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