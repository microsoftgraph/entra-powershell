# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Confirm-AzureADDomain"
    TargetName = "Confirm-MgDomain"
    Parameters = @(
        @{
            SourceName = "Name"
            TargetName = "DomainId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}