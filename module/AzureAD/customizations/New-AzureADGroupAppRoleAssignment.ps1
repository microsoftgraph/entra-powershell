# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADGroupAppRoleAssignment"
    TargetName = "New-MgGroupAppRoleAssignment"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AppRoleId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}