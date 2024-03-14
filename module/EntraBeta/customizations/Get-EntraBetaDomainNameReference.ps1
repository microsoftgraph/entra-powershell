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
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = Get-MgBetaDomainNameReference @params
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