# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADGroup"
    TargetName = "Update-MgGroup"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "Description"
            TargetName = "Description"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "DisplayName"
            TargetName = "DisplayName"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "MailEnabled"
            TargetName = "MailEnabled"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "MailNickName"
            TargetName = "MailNickName"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "SecurityEnabled"
            TargetName = "SecurityEnabled"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}