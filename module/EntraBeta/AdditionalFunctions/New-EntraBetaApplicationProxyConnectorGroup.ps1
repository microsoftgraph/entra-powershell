function New-EntraBetaApplicationProxyConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Name
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "POST"
        $body = @{}
        $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups"
    
        if($null -ne $PSBoundParameters["Name"])
        {
            $body = @{
                "name" = $PSBoundParameters["Name"]
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

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }        
}