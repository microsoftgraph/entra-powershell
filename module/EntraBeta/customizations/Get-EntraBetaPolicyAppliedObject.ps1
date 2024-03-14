# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADPolicyAppliedObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $Id = $PSBoundParameters["Id"]
        $params["Uri"] = "https://graph.microsoft.com/beta/legacy/policies/$Id/appliesTo"
        $params["Method"] = "GET"
        if ($PSBoundParameters.ContainsKey("ID")) {
            $params["Uri"] = "https://graph.microsoft.com/beta/legacy/policies/$Id/appliesTo"
        }
        
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
                
        $response = (Invoke-GraphRequest -Method $params.method -Uri $params.uri | ConvertTo-Json | ConvertFrom-Json).value   
        $response | Add-Member -MemberType AliasProperty -Value '@odata.type' -Name 'odata.type'
        $response  
    }
'@
}