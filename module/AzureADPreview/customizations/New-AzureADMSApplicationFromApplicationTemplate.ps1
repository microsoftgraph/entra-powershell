# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------
@{
    SourceName   = "New-AzureADMSApplicationFromApplicationTemplate"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @"
    PROCESS {
        `$params = @{}
        `$keysChanged = @{`$Id = "ApplicationTemplateId" }
        if (`$null -ne `$PSBoundParameters["Id"]) {
            `$params["ApplicationTemplateId"] = `$PSBoundParameters["Id"]
        }
        if (`$null -ne `$PSBoundParameters["DisplayName"]) {
            `$params["displayName"] = `$PSBoundParameters["displayName"]
        }
        if (`$PSBoundParameters.ContainsKey("Verbose")) {
            `$params["Verbose"] = `$Null
        }
        if (`$PSBoundParameters.ContainsKey("Debug")) {
            `$params["Debug"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")

        `$response = Invoke-MgBetaInstantiateApplicationTemplate @params
        `$response
    }
"@
}