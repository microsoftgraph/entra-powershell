# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDeviceRegisteredOwner"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["DeviceId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["All"])
        {
            if($PSBoundParameters["All"])
            {
                $params["All"] = $Null
            }
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $params["Top"] = $PSBoundParameters["Top"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgBetaDeviceRegisteredOwner @params
        $properties = @{
            ObjectId = "Id"
            DeletionTimestamp = "deletedDateTime"
            DirSyncEnabled = "onPremisesSyncEnabled"
            ImmutableId = "onPremisesImmutableId"
            LastDirSyncTime = "OnPremisesLastSyncDateTime"
            Mobile = "mobilePhone"
            ProvisioningErrors = "onPremisesProvisioningErrors"
            TelephoneNumber = "businessPhones"
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
                $propsToConvert = @('AssignedPlans','assignedLicenses','deviceKeys','identities','provisionedPlans')
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

