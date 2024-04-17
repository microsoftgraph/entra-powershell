function Get-EntraBetaApplicationProxyConnectorGroupMembers {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Parameter( ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $All
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "GET"
        $Id = $PSBoundParameters["Id"]
        $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        if($PSBoundParameters.ContainsKey("Id"))
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        }
        if($PSBoundParameters.ContainsKey("Filter"))
        {
            $f = '$' + 'Filter'
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members?$f=$filter"
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("All"))
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($PSBoundParameters.ContainsKey("top"))
        {
            $t = '$' + 'Top'
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members?$t=$top"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri 
        try {    
            $call = $response.value 
            $call
        }
        catch {
            $response
        }

    }        
}