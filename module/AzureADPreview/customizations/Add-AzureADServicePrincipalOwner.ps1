# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADServicePrincipalOwner"
    TargetName = "New-MgBetaServicePrincipalOwnerByRef"
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "OdataId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}