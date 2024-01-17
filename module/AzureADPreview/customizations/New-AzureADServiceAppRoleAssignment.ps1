# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServiceAppRoleAssignment"
    TargetName = "New-MgBetaServicePrincipalAppRoleAssignment"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AppRoleId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}