# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# 
@{
    SourceName = "Add-AzureADMScustomSecurityAttributeDefinitionAllowedValues"
    TargetName = "New-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue"
    Parameters =
    @(
        @{
            SourceName = "CustomSecurityAttributeDefinitionId"
            TargetName = "CustomSecurityAttributeDefinitionId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "ID"
            TargetName = "ID"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "IsActive"
            TargetName = "IsActive"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    ) 
    Outputs = $null
}