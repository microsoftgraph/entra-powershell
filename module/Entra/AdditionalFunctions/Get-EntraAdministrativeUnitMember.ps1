# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraAdministrativeUnitMember {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $baseUri = "/v1.0/directory/administrativeUnits/$ObjectId/members?`$select=*"    
    $params["Uri"] = "$baseUri"
    if($null -ne $PSBoundParameters["ObjectId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["ObjectId"]
    }
    if($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
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
    if($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
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
        }
    }
    if($data){
        $memberList = @()
        foreach ($response in $data) {
            $memberType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
            if (-not ($response -is [psobject])) {
                $response = [pscustomobject]@{ Value = $response }
            }
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $memberList += $memberType
        }
        $memberList  
    }
    }
}