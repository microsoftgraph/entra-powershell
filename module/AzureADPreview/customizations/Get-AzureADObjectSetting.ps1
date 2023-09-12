# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADObjectSetting"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {  
        `$params = @{}  
                if (`$null -ne `$PSBoundParameters["TargetType"]) {
                    `$params["TargetType"] = `$PSBoundParameters["TargetType"]
                }
                if (`$null -ne `$PSBoundParameters["TargetObjectId"]) {
                    `$params["TargetObjectId"] = `$PSBoundParameters["TargetObjectId"]
                }
                if (`$null -ne `$PSBoundParameters["Top"]) {
                    `$params["Top"] ='?`$top=' +`$PSBoundParameters["Top"]
                }
                if (`$PSBoundParameters.ContainsKey("Debug")) {
                    `$params["Debug"] = `$Null
                }
                if (`$PSBoundParameters.ContainsKey("Verbose")) {
                    `$params["Verbose"] = `$Null
                }
                    Write-Debug("============================ TRANSFORMATIONS ============================")
                    `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
                    Write-Debug("=========================================================================``n")
                    `$Method = "GET"
                    `$URI = 'https://graph.microsoft.com/beta/{0}/{1}/settings' -f `$TargetType,`$TargetObjectId
                    `$response = Invoke-GraphRequest -Uri `$uri -Method `$Method
                    `$response
    }
"@
}