# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADGroupMember"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/groups'
        $properties = '$select=*'
        $Method = "GET"
        $keysChanged = @{ObjectId = "Id"}

        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["GroupId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.GroupId)/members?$properties"
        }
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.GroupId)/members?$properties"
        }
        if($null -ne $PSBoundParameters["Top"] -and  (-not $PSBoundParameters.ContainsKey("All")))
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $URI = "$baseUri/$($params.GroupId)/members?`$top=999&$properties"
            }
            else{
                $URI = "$baseUri/$($params.GroupId)/members?`$top=$topCount&$properties"
            }
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
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
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method
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
        $data 
    }  
'@
}

