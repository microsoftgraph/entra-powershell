# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADGroupMember"
    TargetName = "Remove-MgBetaGroupMemberByRef"
    Parameters = @(
        @{
            SourceName = "MemberId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}