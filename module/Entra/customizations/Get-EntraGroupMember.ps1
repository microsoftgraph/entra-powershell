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
            $URI = "$baseUri/$($params.GroupId)/members?`$top=$topCount&$properties"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            if($null -eq $PSBoundParameters["Top"]){
                while($response.'@odata.nextLink'){
                    $URI = $response.'@odata.nextLink'
                    $response = Invoke-GraphRequest -Uri $URI -Method $Method
                    $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
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