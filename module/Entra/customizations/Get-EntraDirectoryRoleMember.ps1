# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDirectoryRoleMember"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/directoryRoles'
        $properties = '$select=*'
        $Method = "GET"
        $keysChanged = @{ObjectId = "Id"}
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ObjectId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.ObjectId)/members?$properties"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
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
        
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).value
        $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value ServiceProvisioningErrors 
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value businessPhones               
            }
        }
        $response 
        }
'@
}