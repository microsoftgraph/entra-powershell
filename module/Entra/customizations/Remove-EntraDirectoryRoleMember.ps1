# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADDirectoryRoleMember"
    TargetName = "Remove-MgDirectoryRoleMemberByRef"
    Parameters = @(
        @{
            SourceName = "MemberId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ObjectId"
            TargetName = "DirectoryRoleId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}