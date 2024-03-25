# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADScopedRoleMembership"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
        `$keysChanged = @{ObjectId = "Id"}
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["ObjectId"])
        {
            `$params["AdministrativeUnitId"] = `$PSBoundParameters["ObjectId"]
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["ScopedRoleMembershipId"])
        {
            `$params["ScopedRoleMembershipId"] = `$PSBoundParameters["ScopedRoleMembershipId"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember @params -Headers `$customHeaders
        `$response | ForEach-Object {
            if (`$null -ne `$_) {
                
                `$propsToConvert = @('RoleMemberInfo')
        
                foreach (`$prop in `$propsToConvert) {
                    `$value = `$_.`$prop | ConvertTo-Json | ConvertFrom-Json
                    `$_ | Add-Member -MemberType NoteProperty -Name `$prop -Value (`$value) -Force
                }
            }
        }
        `$response
        }
"@
}
