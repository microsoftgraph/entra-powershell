# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName   = "Remove-AzureADPolicy"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$array = ("activityBasedTimeoutPolicies",	"defaultAppManagementPolicy",	"appManagementPolicies",	"authenticationFlowsPolicy",	"authenticationMethodsPolicy",	"claimsMappingPolicies",	"featureRolloutPolicies",	"homeRealmDiscoveryPolicies",	"permissionGrantPolicies",	"tokenIssuancePolicies",	"tokenLifetimePolicies")
    
        foreach (`$a in `$array) {
            `$uri = "https://graph.microsoft.com/beta/policies/" + `$a + "/" + `$id
            try {
                `$response = Invoke-GraphRequest -Uri `$uri -Method GET
                break
            }
            catch {}
        }
        `$policy = (`$response.'@odata.context') -match 'policies/([^/]+)/\`$entity'
    
        `$type = `$Matches[1]
        if ((`$null -ne `$PSBoundParameters["id"]) -and (`$null -ne `$type )) {
            `$URI = "https://graph.microsoft.com/beta/policies/" + `$type + "/" + `$id
        }
        `$Method = "DELETE"
        if (`$PSBoundParameters.ContainsKey("Debug")) {
            `$params["Debug"] = `$Null
        }
        if (`$PSBoundParameters.ContainsKey("Verbose")) {
            `$params["Verbose"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        `$response = Invoke-GraphRequest -Uri `$uri -Method `$Method
        `$response
    }
"@
}