# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraServicePrincipalDelegatedPermissionClassification {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId,
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id
    )

    PROCESS{
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgServicePrincipalDelegatedPermissionClassification -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -DelegatedPermissionClassificationId $PSBoundParameters["Id"]
    }    
}

