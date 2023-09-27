# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSPasswordSingleSignOnCredential"
    TargetName = "Get-MgBetaServicePrincipalPasswordSingleSignOnCredential"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "PasswordSSOObjectId"
            TargetName = "Id"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = `$TmpValue.Id
"@
        }
    )
    Outputs = $null
}