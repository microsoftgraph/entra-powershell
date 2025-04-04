# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Revoke-AzureADSignedInUserAllRefreshToken"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
                
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri 'https://graph.microsoft.com/beta/me/revokeSignInSessions' -Method POST).value      
        if($response){
                $responseType = New-Object Microsoft.Graph.Beta.PowerShell.Models.ComponentsMwc6EoResponsesRevokesigninsessionsresponseContentApplicationJsonSchema
                $responseType.Value= $response
                $responseType
        }
    }  
'@
}