# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADServicePrincipalPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Id"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PolicyId"]) {
            $params["PolicyId"] = $PSBoundParameters["PolicyId"]
        }
        $Method = "DELETE"
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $URI = 'https://graph.microsoft.com/beta/serviceprincipals/{0}/policies/{1}/$ref' -f $Id,$PolicyId
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }    
'@
}