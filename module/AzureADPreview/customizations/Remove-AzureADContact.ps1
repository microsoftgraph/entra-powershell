# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADContact"
    TargetName = "Remove-MgBetaContact"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "OrgContactId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
    CustomScript =$null
}