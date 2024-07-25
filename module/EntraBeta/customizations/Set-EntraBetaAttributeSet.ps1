# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSAttributeSet"
    TargetName = "Update-MgBetaDirectoryAttributeSet"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AttributeSetId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}

