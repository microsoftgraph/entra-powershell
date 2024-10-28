# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Revoke-EntraSignedInUserAllRefreshToken {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (

    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri 'https://graph.microsoft.com/v1.0/me/revokeSignInSessions' -Method POST).value
        if($response){
            $responseType = New-Object Microsoft.Graph.PowerShell.Models.ComponentsMwc6EoResponsesRevokesigninsessionsresponseContentApplicationJsonSchema
            $responseType.Value= $response
            $responseType
        }
    }    
}

