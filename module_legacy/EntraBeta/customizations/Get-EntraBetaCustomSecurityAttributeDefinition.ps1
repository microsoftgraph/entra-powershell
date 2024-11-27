# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSCustomSecurityAttributeDefinition"
    TargetName = "Get-MgBetaDirectoryCustomSecurityAttributeDefinition"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "CustomSecurityAttributeDefinitionId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
    
}