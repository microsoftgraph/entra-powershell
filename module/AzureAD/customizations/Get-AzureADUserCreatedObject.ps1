# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserCreatedObject"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/users'
        $properties = '$select=*'
        $Method = "GET"
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.UserId)/createdObjects?$properties"
        }
        
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.UserId)/createdObjects?$properties"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.UserId)/createdObjects?`$top=$topCount&$properties"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = (Invoke-GraphRequest -Uri $URI -Method $Method).value
        $response = $response | ConvertTo-Json -depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value deletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name AppOwnerTenantId -Value appOwnerOrganizationId
            }
        }
        $response 
        }
'@
}