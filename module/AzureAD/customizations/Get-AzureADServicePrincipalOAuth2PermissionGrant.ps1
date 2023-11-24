# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalOAuth2PermissionGrant"
    TargetName = "Get-MgBetaServicePrincipalOauth2PermissionGrant"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}