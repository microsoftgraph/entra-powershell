# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    Remove-MgServicePrincipalPassword -ServicePrincipalId $PSBoundParameters["ObjectId"] -KeyId $PSBoundParameters["KeyId"]
'@
}