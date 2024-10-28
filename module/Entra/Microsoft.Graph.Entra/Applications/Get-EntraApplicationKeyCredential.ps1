# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraApplicationKeyCredential {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId
    )

     PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        (Get-MgApplication -Headers $customHeaders -ApplicationId $PSBoundParameters["ObjectId"]).KeyCredentials
    }    
}

