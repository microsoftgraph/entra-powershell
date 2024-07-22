function Get-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $baseUri = "/v1.0/directory/administrativeUnits"
    $properties = '$select=*'
    $params["Uri"] = "$baseUri/?$properties"
    if($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if($null -ne $PSBoundParameters["ObjectId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["ObjectId"]
        $params["Uri"] = "$baseUri/$($params.AdministrativeUnitId)?$properties"
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $Null
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
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $Null
    }
    if($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if($null -ne $PSBoundParameters["All"])
    {
        $uri = $baseUri
    }
    if($null -ne $PSBoundParameters["Top"] -and  (-not $PSBoundParameters.ContainsKey("All")))
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else{
                $params["Uri"] += "&`$top=$topCount"
            }
        }
    if($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if($null -ne $PSBoundParameters["Filter"])
    {
        $params["Filter"] = $PSBoundParameters["Filter"]
        $Filter = $PSBoundParameters["Filter"]
        $f = '$' + 'Filter'
        $params["Uri"] += "&$f=$Filter"
    }
    if($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET)
    if($response.ContainsKey('value')){
        $response = $response.value
    }

    $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json

    try {
        $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $all = $All.IsPresent
        $increment = $topCount - $data.Count
        while ($response.'@odata.nextLink' -and (($all) -or ($increment -gt 0 -and -not $all))) {
            $URI = $response.'@odata.nextLink'
            if (-not $all) {
                $topValue = [Math]::Min($increment, 999)
                $URI = $URI.Replace('$top=999', "`$top=$topValue")
                $increment -= $topValue
            }
            $response = Invoke-GraphRequest -Uri $URI -Method $Method
            $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
    } catch {} 
    $data | ForEach-Object {
        if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimeStamp -Value deletedDateTime
        }
    }
    
    $aulist = @()
    foreach($item in $data){
        $auType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAdministrativeUnit
        $item.PSObject.Properties | ForEach-Object {
            $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
            $propertyValue = $_.Value
            $auType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
        }
        $aulist += $auType
    }
    $aulist
    }
}