# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUser"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $upnPresent = $false
        $baseUri = 'https://graph.microsoft.com/beta/users'
        $properties = $null
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"
        $query = $null
        
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $query = "$properties"
        }

        if($PSBoundParameters.ContainsKey("Top"))
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $query += "&`$top=999"
            }
            else{
                $query += "&`$top=$topCount"
            }
        }
        
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=`"userprincipalname:$TmpValue`" OR `"state:$TmpValue`" OR `"mailNickName:$TmpValue`" OR `"mail:$TmpValue`" OR `"jobTitle:$TmpValue`" OR `"displayName:$TmpValue`" OR `"department:$TmpValue`" OR `"country:$TmpValue`" OR `"city:$TmpValue`""
            $query += "&$SearchString"
            $customHeaders['ConsistencyLevel'] = 'eventual'
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $UserId = $PSBoundParameters["ObjectId"]
            if ($UserId -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'){
                $f = '$' + 'Filter'
                $Filter = "UserPrincipalName eq '$UserId'"
                $query += "&$f=$Filter"
                $upnPresent = $true
            }
            else{                
                $params["Uri"] = "$baseUri/$($UserId)"
            }
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $query += "&$f=$Filter"
        }    

        if($null -ne $query)
        {
            $query = "?" + $query.TrimStart("&")
            $params["Uri"] += $query
        }
	    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if ($upnPresent -and ($null -eq $response.value -or $response.value.Count -eq 0)){
            Write-Error "Resource '$ObjectId' does not exist or one of its queried reference-property objects are not present.

Status: 404 (NotFound)
ErrorCode: Request_ResourceNotFound"
        }
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while (($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if ($increment -gt 0) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        } catch {}        
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value ExternalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value ExternalUserStateChangeDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ImmutableId -Value onPremisesImmutableId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value onPremisesProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value BusinessPhones
            }
        }
        $userList = @()
        foreach ($response in $data) {
            $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUser
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList 
    }
'@
}
