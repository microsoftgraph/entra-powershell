# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADDomain"
    TargetName = "New-MgBetaDomain"
    Parameters = @(
        @{
            SourceName = "Name"
            TargetName = "Id"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}