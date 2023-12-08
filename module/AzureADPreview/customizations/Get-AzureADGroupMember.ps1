# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADGroupMember"
    TargetName = "Get-MgBetaGroupMember"
    Parameters = $null
    Outputs = @(
        @{
            SourceName = "AdditionalProperties"
            TargetName = "AdditionalProperties"
            ConversionType = "FlatObject"
            SpecialMapping = $null
        }
    )
    
}