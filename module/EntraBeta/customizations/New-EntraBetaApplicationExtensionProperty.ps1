# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADApplicationExtensionProperty"
    TargetName = "New-MgBetaApplicationExtensionProperty"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ApplicationId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}