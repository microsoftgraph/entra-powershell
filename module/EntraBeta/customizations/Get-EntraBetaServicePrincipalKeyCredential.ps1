# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalKeyCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    (Get-MgBetaServicePrincipal ServicePrincipalId `$PSBoundParameters["ObjectId"]).KeyCredentials
"@
}