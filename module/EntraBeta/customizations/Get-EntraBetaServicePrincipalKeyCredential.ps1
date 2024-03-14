# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalKeyCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
    $response = (Get-MgBetaServicePrincipal -ServicePrincipalId $PSBoundParameters["ObjectId"]).KeyCredentials
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
        Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response
'@
}