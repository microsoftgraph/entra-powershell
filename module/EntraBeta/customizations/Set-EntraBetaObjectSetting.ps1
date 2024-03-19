# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADObjectSetting"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {  
        `$params = @{}
        `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
                if (`$null -ne `$PSBoundParameters["TargetType"]) {
                    `$params["TargetType"] = `$PSBoundParameters["TargetType"]
                }
                if (`$null -ne `$PSBoundParameters["TargetObjectId"]) {
                    `$params["TargetObjectId"] = `$PSBoundParameters["TargetObjectId"]
                }
                if (`$null -ne `$PSBoundParameters["DirectorySetting"]) {
                    `$params["DirectorySetting"] = `$PSBoundParameters["DirectorySetting"]
                }
                if (`$null -ne `$PSBoundParameters["ID"]) {
                    `$params["ID"] = `$PSBoundParameters["ID"]
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
                    `$directorySettingsJson =  `$DirectorySetting| ForEach-Object {
                        `$NonEmptyProperties = `$_.psobject.Properties | Where-Object {`$_.Value} | Select-Object -ExpandProperty Name
                        `$propertyValues = `$_ | Select-Object -Property `$NonEmptyProperties | ConvertTo-Json
                        [regex]::Replace(`$propertyValues,'(?<=")(\w+)(?=":)',{`$args[0].Groups[1].Value.ToLower()})
                         }
                    `$response =  Invoke-GraphRequest -Headers `$customHeaders -Method PATCH -Uri https://graph.microsoft.com/beta/`$TargetType/`$TargetObjectId/settings/`$ID -Body `$directorySettingsJson
                    `$response | ConvertTo-Json | ConvertFrom-Json
    }
"@
}