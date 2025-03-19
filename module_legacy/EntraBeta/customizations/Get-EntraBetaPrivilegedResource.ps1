# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSPrivilegedResource"
    TargetName = "Get-MgBetaPrivilegedAccessResource"
    Parameters = @(
        @{
            SourceName = "ProviderId"
            TargetName = "PrivilegedAccessId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "Id"
            TargetName = "GovernanceResourceId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}
