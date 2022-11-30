# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADGroupMember"
    TargetName = "New-MgGroupMember"
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "DirectoryObjectId"
            ConversionType = 2
            SpecialMapping = $null
        }
    )
    Outputs = $null
}