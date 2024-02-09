# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSUser"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
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
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$params["UserId"] = `$PSBoundParameters["Id"]
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

        if(`$null -ne `$PSBoundParameters["SearchString"])
        {
            `$params["Search"] = "DisplayName:"+`$PSBoundParameters["SearchString"]
            `$params["ConsistencyLevel"] = "eventual"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Get-MgUser @params | ConvertTo-Json | ConvertFrom-Json
        if(`$null -ne `$PSBoundParameters["Select"])
        {
            `$response = `$response | Select `$PSBoundParameters["Select"]
        }

        `$response
        }
"@
}