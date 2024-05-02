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
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
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
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $URI = "$baseUri/$($params.GroupId)/members?`$top=999&$properties"
            }
            else{
                $URI = "$baseUri/$($params.GroupId)/members?`$top=$topCount&$properties"
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            if($null -ne $PSBoundParameters["All"] -and $false -ne $PSBoundParameters["All"]){
                while($response.'@odata.nextLink'){
                    $URI = $response.'@odata.nextLink'
                    $response = Invoke-GraphRequest -Uri $URI -Method $Method
                    $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                }
            }
            else{
                $increment = $topCount - $data.Count
                while ($increment -gt 0) {
                    $URI = $response.'@odata.nextLink'
                    if ($increment -gt 999) {
                        $URI = $URI.Replace('$top=999', "`$top=999")
                        $response = Invoke-GraphRequest -Uri $URI -Method $Method
                        $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                        $increment -= 999
                    } else {
                        $URI = $URI.Replace('$top=999', "`$top=$increment")
                        $response = Invoke-GraphRequest -Uri $URI -Method $Method
                        $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                        $increment = 0
                    }
                }
            }   
        }catch {}
        $data | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $data 
    }  
'@
}