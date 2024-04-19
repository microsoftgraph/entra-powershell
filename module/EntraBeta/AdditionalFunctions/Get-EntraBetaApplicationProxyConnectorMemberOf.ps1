function Get-EntraBetaApplicationProxyConnectorMemberOf {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id
    )

    PROCESS {    
        $params = @{}
<<<<<<< HEAD
=======
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
>>>>>>> 31db28755411a8424d7390ba4f50785d3ea3da1a
        $params["Method"] = "GET"
        $Id = $PSBoundParameters["Id"]
        $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$Id/memberOf"
        if($PSBoundParameters.ContainsKey("Id"))
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$Id/memberOf"
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

<<<<<<< HEAD
        $response = Invoke-GraphRequest -Method $params.method -Uri $params.uri 
=======
        $response = Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri 
>>>>>>> 31db28755411a8424d7390ba4f50785d3ea3da1a
        try {    
            $call = $response.value 
            $call
        }
        catch {
            $response
        }

    }        
}