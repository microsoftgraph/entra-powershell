# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationKeyCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
     PROCESS {
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        (Get-MgBetaApplication -ApplicationId $PSBoundParameters["ObjectId"]).KeyCredentials
    }
'@
}