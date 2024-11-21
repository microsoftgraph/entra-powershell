# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalMembership"
    TargetName = "Get-MgServicePrincipalTransitiveMemberOf"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = @(
        @{
            SourceName = "AdditionalProperties"
            TargetName = "AdditionalProperties"
            ConversionType = "FlatObject"
            SpecialMapping = $null
        }
    )
}