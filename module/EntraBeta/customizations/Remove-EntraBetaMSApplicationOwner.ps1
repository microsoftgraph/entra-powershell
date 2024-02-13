# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSApplicationOwner"
    TargetName = "Remove-MgBetaApplicationOwnerByRef"
    Parameters = @(
        @{
            SourceName = "ObjectID"
            TargetName = "ApplicationId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            
            SourceName = "OwnerId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}