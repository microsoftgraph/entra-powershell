# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationProxyApplication"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @"
    PROCESS {        
        `$params = @{}
        if (`$PSBoundParameters.ContainsKey("Debug")) {
            `$params["Debug"] = `$Null
        }
        if (`$null -ne `$PSBoundParameters["ObjectId"]) {
            `$params["ApplicationId"] = `$PSBoundParameters["ObjectId"]
            `$params["Select"] = "onPremisesPublishing"
        }
        if (`$PSBoundParameters.ContainsKey("Verbose")) {
            `$params["Verbose"] = `$Null
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$app = Get-MgBetaApplication @params
        `$response = `$app.OnPremisesPublishing
        `$response | ForEach-Object {
            if (`$null -ne `$_) {
                Add-Member -InputObject `$_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        `$response
    }
"@
}
