# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSPrivilegedRoleSetting"
    TargetName = $null
    Parameters = $Null
    Outputs = $null

    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{}

        if($null -ne $PSBoundParameters["ProviderId"])
        {
            $params["PrivilegedAccessId"] = $PSBoundParameters["ProviderId"]
        }

        if($null -ne $PSBoundParameters["Id"])
        {
            $params["GovernanceRoleSettingId"] = $PSBoundParameters["Id"]
        }

        if($null -ne $PSBoundParameters["Filter"])
        {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach($i in $keysChanged.GetEnumerator()){
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $params["Top"] = $PSBoundParameters["Top"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = Get-MgBetaPrivilegedAccessRoleSetting @params
        $response | ForEach-Object {
            if ($null -ne $_) {
                $propsToConvert = @('AdminEligibleSettings', 'AdminMemberSettings', 'UserEligibleSettings','UserMemberSettings')
        
                foreach ($prop in $propsToConvert) {
                    $value = $_.$prop | ConvertTo-Json | ConvertFrom-Json
                    $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                }
            }
        }

        $response
    }
'@

}
