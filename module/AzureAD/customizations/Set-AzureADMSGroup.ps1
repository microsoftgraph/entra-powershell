# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSGroup"
    TargetName = "Update-MgGroup"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}