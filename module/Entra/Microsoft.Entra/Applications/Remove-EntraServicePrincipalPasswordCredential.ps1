# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $KeyId,
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId
    )

    PROCESS{
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgServicePrincipalPassword -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -KeyId $PSBoundParameters["KeyId"]
    }    
}

