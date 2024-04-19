function Remove-EntraBetaApplicationProxyConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "DELETE"
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id"
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

        Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri 
    }        
}