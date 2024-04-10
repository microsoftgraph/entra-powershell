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
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
                if (`$null -ne `$PSBoundParameters["TargetType"]) {
                    `$params["TargetType"] = `$PSBoundParameters["TargetType"]
                }
                if (`$null -ne `$PSBoundParameters["TargetObjectId"]) {
                    `$params["TargetObjectId"] = `$PSBoundParameters["TargetObjectId"]
                }
                if (`$null -ne `$PSBoundParameters["ID"]) {
                    `$params["ID"] = `$PSBoundParameters["ID"]
                }
                if (`$null -ne `$PSBoundParameters["Top"]) {
                    `$params["Top"] ='?`$top=' +`$PSBoundParameters["Top"]
                }
                if (`$PSBoundParameters["All"]) {
                    `$params["Top"] ='?`$top=999'
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
                    `$URI = 'https://graph.microsoft.com/beta/{0}/{1}/settings/' -f `$TargetType,`$TargetObjectId
                    if(`$null -ne `$PSBoundParameters["ID"]){
                        `$URI = 'https://graph.microsoft.com/beta/{0}/{1}/settings/{2}' -f `$TargetType,`$TargetObjectId,`$ID
                        `$response = (Invoke-GraphRequest -Uri `$uri -Method `$Method) | ConvertTo-Json | ConvertFrom-Json
                         return `$response
                    }
                    elseif(`$null -ne `$params["Top"]){
                        `$URI = 'https://graph.microsoft.com/beta/{0}/{1}/settings/{2}' -f `$TargetType,`$TargetObjectId,`$params["Top"]
                    }
                    `$rawresponse = (Invoke-GraphRequest -Headers `$customHeaders -Uri `$uri -Method `$Method).Value
                    `$response = `$rawresponse | ConvertTo-Json -Depth 3 | ConvertFrom-Json
                    `$response | ForEach-Object {Add-Member -InputObject `$_ -NotePropertyName "TargetType" -NotePropertyValue `$TargetType; Add-Member -InputObject `$_ -NotePropertyName "TargetObjectID" -NotePropertyValue `$TargetObjectId}
                    `$response
    }
"@
}