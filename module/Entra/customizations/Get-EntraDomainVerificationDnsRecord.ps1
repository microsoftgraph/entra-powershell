# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDomainVerificationDnsRecord"
    TargetName = "Get-MgDomainVerificationDnsRecord"
    Parameters = @(
        @{
            SourceName = "Name"
            TargetName = "DomainId"
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
        @{
            SourceName = "Id"
            TargetName = "DnsRecordId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
}