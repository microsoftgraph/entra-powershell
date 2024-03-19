# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDirectoryRoleMember"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["DirectoryRoleId"] = $PSBoundParameters["ObjectId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        try {
            $response = Get-MgBetaDirectoryRoleMember @params -Headers $customHeaders
            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value ServiceProvisioningErrors 
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value businessPhones       
                    $propsToConvert = @('assignedLicenses','assignedPlans','identities','provisionedPlans')
                    foreach ($prop in $propsToConvert) {
                        $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                        $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                    }
                }
            }
            $response
        }
        catch {}
        }
'@
}