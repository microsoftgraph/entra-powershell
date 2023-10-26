# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADGroupAppRoleAssignment"
    TargetName = "Get-MgBetaGroupAppRoleAssignment"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}