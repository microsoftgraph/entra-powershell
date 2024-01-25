# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADUserAppRoleAssignment"
    TargetName = "New-MgUserAppRoleAssignment"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "UserId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "Id"
            TargetName = "AppRoleId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}