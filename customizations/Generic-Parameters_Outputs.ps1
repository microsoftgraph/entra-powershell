# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = $null
    TargetName = $null
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "Id"
            ConversionType = 5
            SpecialMapping = $null
        },
        @{
            SourceName = "Id"
            TargetName = "Id"
            ConversionType = 5
            SpecialMapping = $null
        }
    )
    Outputs = @(
        @{
            SourceName = "Id"
            TargetName = "ObjectId"
            ConversionType = 2
            SpecialMapping = $null
        }
    )
}