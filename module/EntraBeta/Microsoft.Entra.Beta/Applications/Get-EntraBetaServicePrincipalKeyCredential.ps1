# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaServicePrincipalKeyCredential {
    function Get-EntraBetaServicePrincipalKeyCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("ObjectId")]
    [System.String] $ServicePrincipalId
    )

    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    $response = (Get-MgBetaServicePrincipal -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"]).KeyCredentials
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
        Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response    
}    
}

