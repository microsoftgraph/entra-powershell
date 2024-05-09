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
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{Name = "DomainId"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["Name"])
        {
            $params["DomainId"] = $PSBoundParameters["Name"]
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
        
        $response = Get-MgBetaDomainNameReference @params -Headers $customHeaders
        $properties = @{
            ObjectId = "Id"
            DeletionTimestamp = "deletedDateTime"
            DirSyncEnabled = "onPremisesSyncEnabled"
            ImmutableId = "onPremisesImmutableId"
            Mobile = "mobilePhone"
            ProvisioningErrors = "onPremisesProvisioningErrors"
            TelephoneNumber = "businessPhones"
            UserState = "externalUserState"
            UserStateChangedOn = "externalUserStateChangeDate"
        }
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties 
                foreach ($prop in $properties.GetEnumerator()) {
                    $propertyName = $prop.Name
                    $propertyValue = $prop.Value
                    if ($_.PSObject.Properties.Match($propertyName)) {
                        $_ | Add-Member -MemberType AliasProperty -Name $propertyName -Value $propertyValue
                    }
                }
                $propsToConvert = @('provisionedPlans','assignedPlans','assignedLicenses','appRoles','keyCredentials','identities')
                foreach ($prop in $propsToConvert) {
                    try {
                        if($_.PSObject.Properties.Match($prop)) {
                            $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                            $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force   
                        }
                    }
                    catch {}    
                }
    
            }
        }
        $response 
    }   
'@
}