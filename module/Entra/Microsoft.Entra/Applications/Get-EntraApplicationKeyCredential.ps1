# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraApplicationKeyCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("ObjectId")]
        [System.String] $ApplicationId
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        (Get-MgApplication -Headers $customHeaders -ApplicationId $PSBoundParameters["ApplicationId"]).KeyCredentials
    }    
}

