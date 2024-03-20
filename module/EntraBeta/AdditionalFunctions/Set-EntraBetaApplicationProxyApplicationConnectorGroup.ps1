function Set-EntraBetaApplicationProxyApplicationConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ConnectorGroupId
    )

    PROCESS {    
        $params = @{}
        $params["Method"] = "PUT"
        $body = @{}
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/applications/$ObjectId/connectorGroup/" + '$ref'
        }
        if($null -ne $PSBoundParameters["ConnectorGroupId"])
        {
            $body = @{
                "@odata.id" = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            } 
            $body = $body | ConvertTo-Json
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }        
}