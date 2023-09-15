# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSPasswordSingleSignOnCredential"
    TargetName = "New-MgBetaServicePrincipalPasswordSingleSignOnCredential"
    Parameters =  @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "PasswordSSOCredential"
            TargetName = "Credentials"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}