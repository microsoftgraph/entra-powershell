# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSCustomSecurityAttributeDefinition"
    TargetName = "Update-MgBetaDirectoryCustomSecurityAttributeDefinition"
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

