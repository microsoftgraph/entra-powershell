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
        },
        @{
            SourceName = "Feature"
            TargetName = "Feature"
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
            SourceName = "Description"
            TargetName = "Description"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "IsEnabled"
            TargetName = "IsEnabled"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "IsAppliedToOrganization"
            TargetName = "IsAppliedToOrganization"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AppliesTo"
            TargetName = "AppliesTo"
            ConversionType = 5
            SpecialMapping = $null
        }
    )
    Outputs = $null
}