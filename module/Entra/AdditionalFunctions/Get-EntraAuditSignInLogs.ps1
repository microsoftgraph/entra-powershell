function Get-EntraAuditSignInLogs {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (

    [Parameter(ParameterSetName = "GetById", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,

    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,

    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,

    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter

    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/auditLogs/signIns'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"+"?"

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

        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $UserId = $PSBoundParameters["ObjectId"]
            $params["Uri"] = "$baseUri/$($UserId)"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }        
	    if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $data = $response | ConvertTo-Json -Depth 100 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 100 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while ($response.'@odata.nextLink' -and (($all) -or ($increment -gt 0 -and -not $all))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if (-not $all) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 100 | ConvertFrom-Json
            }
        } catch {}        

        # $logList = @()
        # foreach ($response in $data) {
        #     $logType = New-Object Microsoft.Open.MSGraph.Model.MicrosoftGraphSignIn
        #     $response.PSObject.Properties | ForEach-Object {
        #         $propertyName = $_.Name
        #         $propertyValue = $_.Value
        #         $logType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force                
        #     }
        #     $logList += $logType
        # }
        # $logList

        $data
        
    }      
}