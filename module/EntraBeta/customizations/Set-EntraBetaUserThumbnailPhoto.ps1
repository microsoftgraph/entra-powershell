# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADUserThumbnailPhoto"
    TargetName = "Set-MgBetaUserPhotoContent"
    Parameters = @(
        @{
            SourceName = "FilePath"
            TargetName = "InFile"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}