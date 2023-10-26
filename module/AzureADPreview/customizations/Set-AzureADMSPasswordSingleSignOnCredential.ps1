# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSPasswordSingleSignOnCredential"
    TargetName = "Update-MgBetaServicePrincipalPasswordSingleSignOnCredential"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "PasswordSSOCredential"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = `$TmpValue | ConvertTo-Json
"@
        }
    )
    Outputs = $null
}