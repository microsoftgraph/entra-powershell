function Set-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Description,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $UsePreDefinedValuesOnly,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Status
    )

    PROCESS {    
    $params = @{}
    $body = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $Uri = "https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions/$Id"
    $Method = "PATCH"
    $keysChanged = @{}
    if($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if($null -ne $PSBoundParameters["Id"])
    {
        $params["Id"] = $PSBoundParameters["Id"]
    }
    if($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $Null
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $Null
    }
    if($null -ne $PSBoundParameters["Description"])
    {
        $body["description"] = $PSBoundParameters["Description"]  
    }
    if($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if($null -ne $PSBoundParameters["UsePreDefinedValuesOnly"])
    {
        $body["usePreDefinedValuesOnly"] = $PSBoundParameters["UsePreDefinedValuesOnly"]
    }
    if($null -ne $PSBoundParameters["Status"])
    {
        $body["status"] = $PSBoundParameters["Status"]
    }
    if($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    
        $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders
        $response

    }
}