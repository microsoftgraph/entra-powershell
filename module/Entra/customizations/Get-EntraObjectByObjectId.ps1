# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADObjectByObjectId"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $body = @{}
        $keysChanged = @{ObjectIds = "Ids"}
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Types"])
        {
            $body["Types"] = $PSBoundParameters["Types"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectIds"])
        {
            $body["Ids"] = $PSBoundParameters["ObjectIds"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Uri 'https://graph.microsoft.com/v1.0/directoryObjects/microsoft.graph.getByIds?$select=*' -Method POST -Body $body 
        $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
    }    
'@
}