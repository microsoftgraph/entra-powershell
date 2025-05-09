# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the password credential object (Password Credential Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $KeyId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the service principal object (Service Principal Object ID).")]
        [ValidateNotNullOrEmpty()]
        [Alias("ObjectId")]
        [System.String] $ServicePrincipalId
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgServicePrincipalPassword -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -KeyId $PSBoundParameters["KeyId"]
    }    
}

