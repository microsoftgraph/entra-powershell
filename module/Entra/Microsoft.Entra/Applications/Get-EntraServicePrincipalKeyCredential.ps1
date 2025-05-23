# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraServicePrincipalKeyCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ServicePrincipalId
    )

    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $response = (Get-MgServicePrincipal -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"]).KeyCredentials
    $response | ForEach-Object {
        if ($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
            Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response    
}

