# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDomain"
    TargetName = "Get-MgBetaDomain"
    Parameters = @(
        @{
            SourceName = "Name"
            TargetName = "DomainId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = @{
        SourceName = "Id"
        TargetName = "Name"
        ConversionType = "Name"
        SpecialMapping = $null
    }
}