# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDomainNameReference"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/domains'
        $properties = '$select=*'
        $Method = "GET"
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["Name"])
        {
            $params["DomainId"] = $PSBoundParameters["Name"]
            $URI = "$baseUri/$($params.DomainId)/domainNameReferences?$properties"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = (Invoke-GraphRequest -Uri $URI -Method $Method).value
        $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value deletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value onPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ImmutableId -Value onPremisesImmutableId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value onPremisesProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value businessPhones
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value externalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value externalUserStateChangeDate
            }
        }
        $response 
        }
'@
}