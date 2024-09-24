# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADContactMembership"
    TargetName = "Get-MgContactMemberOf"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "OrgContactId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = @(
        @{
            SourceName = "AdditionalProperties"
            TargetName = "AdditionalProperties"
            ConversionType = "FlatObject"
            SpecialMapping = $null
        }
    )
}