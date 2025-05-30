# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the service principal object (Service Principal Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ServicePrincipalId
    )

    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    $response = (Get-MgBetaServicePrincipal -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"]).PasswordCredentials
    $response | ForEach-Object {
        if ($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
            Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response    
}

