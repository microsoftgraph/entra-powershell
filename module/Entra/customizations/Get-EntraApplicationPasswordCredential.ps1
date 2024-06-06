# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    (Get-MgApplication -Headers $customHeaders -ApplicationId $PSBoundParameters["ObjectId"]).PasswordCredentials
'@
}