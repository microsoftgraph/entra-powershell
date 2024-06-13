function Set-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Description,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DisplayName
    )

    PROCESS {    
    $params = @{}
    $body = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $keysChanged = @{}
    if($null -ne $PSBoundParameters["ObjectId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["ObjectId"]
    }
    if($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        $body["DisplayName"] = $PSBoundParameters["DisplayName"]
    } 
    if($null -ne $PSBoundParameters["Description"])
    {
        $params["Description"] = $PSBoundParameters["Description"]
        $body["Description"] = $PSBoundParameters["Description"]
    }
    if($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
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
    if($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }

    $uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)"
    $params["Uri"] = $uri

    $body = $body | ConvertTo-Json

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")

    $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method PATCH -Body $body
    $response = $response | ConvertTo-Json | ConvertFrom-Json
    $response | ForEach-Object {
        if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
        }
    }
    $response
    }
}