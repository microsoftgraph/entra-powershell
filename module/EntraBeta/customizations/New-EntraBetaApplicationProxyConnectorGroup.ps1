# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADApplicationProxyConnectorGroup"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $URI = 'https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups'
        $Method = "POST"
        if($null -ne $PSBoundParameters["Name"])
        {
            $params["Name"] = $PSBoundParameters["Name"]
        }
        $Name = $params["Name"]
        $NameValue = $Name._Name
        $body = @{
            name = $NameValue
        }
        $body = $body | ConvertTo-Json
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = Invoke-GraphRequest -Uri $URI -Method $Method -Body $body
        $response = $response | ConvertTo-Json | ConvertFrom-Json
        $response = $response | Select-Object Id, Name, ConnectorGroupType, IsDefault
        $response 
    }
'@
}