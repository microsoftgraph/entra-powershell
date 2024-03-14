# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADAuditSignInLogs"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-CustomHeaders -Module Entra -Command `$MyInvocation.MyCommand
        `$keysChanged = @{}
        if(`$null -ne `$PSBoundParameters["Filter"])
        {
            `$TmpValue = `$PSBoundParameters["Filter"]
            foreach(`$i in `$keysChanged.GetEnumerator()){
                `$TmpValue = `$TmpValue.Replace(`$i.Key, `$i.Value)
            }
            `$Value = `$TmpValue
            `$params["Filter"] = `$Value
        }
        if(`$null -ne `$PSBoundParameters["Top"])
        {
            `$params["Top"] = `$PSBoundParameters["Top"]
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["All"])
        {
            if(`$PSBoundParameters["All"])
            {
                `$params["All"] = `$Null
            }
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Get-MgBetaAuditLogSignIn @params
        `$response | ForEach-Object {
            if (`$null -ne `$_) {
                `$_ | Add-Member -MemberType AliasProperty -Name RiskEventTypes -Value RiskEventTypesV2 -Force
        
                `$propsToConvert = @('MfaDetail', 'AppliedConditionalAccessPolicies', 'NetworkLocationDetails', 'Location', 'DeviceDetail', 'Status', 'AuthenticationProcessingDetails')
        
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
