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

        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["GroupId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.GroupId)/members?$properties"
        }
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.GroupId)/members?$properties"
        }
        if($null -ne $PSBoundParameters["Top"])
        if($null -ne $PSBoundParameters["Top"])
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $minTop = 999
                $URI = "$baseUri/$($params.GroupId)/members?`$top=999&$properties"
            }
            else{
                $URI = "$baseUri/$($params.GroupId)/members?`$top=$topCount&$properties"
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $data = $response
        try {
            $data = @($response.value) 
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while (($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0))) {
            while (($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0))) {
                $URI = $response.'@odata.nextLink'
                if ($increment -gt 0) {
                if ($increment -gt 0) {
                    $topValue = [Math]::Min($increment, 999)
                    if($minTop){
                        $URI = $URI.Replace("`$top=$minTop", "`$top=$topValue")
                    }
                    else{
                        $URI = $URI.Replace("`$top=$topCount", "`$top=$topValue")
                    }
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
        if (($data.count -eq 0) -or $data.'@odata.type' -notcontains 'microsoft.graph.servicePrincipal') {
            $URI = "$baseUri/$($params.GroupId)/members/microsoft.graph.servicePrincipal?$properties"
            $topCount = $Top - $data.count
            if ($PSBoundParameters.ContainsKey("Top") -and $topCount -gt 0) {
                $URI = "$baseUri/$($params.GroupId)/members/microsoft.graph.servicePrincipal?`$top=$topCount&$properties"
                $response = Invoke-GraphRequest -Uri $URI -Method $Method
                $serviceprincipal += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
            elseif($null -eq $PSBoundParameters["Top"]){
                $response = Invoke-GraphRequest -Uri $URI -Method $Method
                $serviceprincipal += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
            try{
                $serviceprincipal | ForEach-Object {
                    if($null -ne $_) {
                        Add-Member -InputObject $_ -MemberType NoteProperty -Name '@odata.type' -Value '#microsoft.graph.servicePrincipal'
                    }
                }
                $data += $serviceprincipal
            }
            catch {}
        }
        if($data){
            $userList = @()
            foreach ($response in $data) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                if (-not ($response -is [psobject])) {
                    $response = [pscustomobject]@{ Value = $response }
                }
                $response.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList  
        }
    }   
'@
}