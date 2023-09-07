# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$baseUrl = "https://graph.microsoft.com/beta/policies/"
        `$endpoints = @("homeRealmDiscoveryPolicies", "claimsMappingPolicies", "tokenIssuancePolicies", "tokenLifetimePolicies", "activityBasedTimeoutPolicies", "featureRolloutPolicies", 	"defaultAppManagementPolicy", "appManagementPolicies", "authenticationFlowsPolicy",	"authenticationMethodsPolicy", "permissionGrantPolicies")
        
        `$response = @()
        foreach (`$endpoint in `$endpoints) {
            `$url = "`${baseUrl}`${endpoint}"
            try {
                `$policies = (Invoke-GraphRequest -Uri `$url -Method GET).value
            }
            catch {
                `$policies = (Invoke-GraphRequest -Uri `$url -Method GET)
            }
            `$policies | ForEach-Object {
                `$_.Type = (`$endpoint.Substring(0, 1).ToUpper() + `$endpoint.Substring(1) -replace "ies", "y")
                `$response += `$_
                if (`$Top -and (`$response.Count -ge `$Top)) {
                    break 
                }
            }
        }

        if (`$PSBoundParameters.ContainsKey("Debug")) {
            `$params["Debug"] = `$Null
        }
        if (`$PSBoundParameters.ContainsKey("Verbose")) {
            `$params["Verbose"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        `$response | ForEach-Object {
            if (`$null -ne `$_) {
                foreach (`$Keys in `$_.Keys) { 
                    `$Keys=`$Keys.SubString(0, 1).ToUpper() + `$Keys.Substring(1)
                    `$_ | Add-Member -MemberType NoteProperty -Name `$Keys -Value (`$_.`$Keys) -Force
                }
            }
        }
        
        if (`$PSBoundParameters.ContainsKey("ID")) {
            `$response = `$response | Where-Object { `$_.id -eq `$Id }
            if(`$Null -eq `$response ) {
                Write-Error "Get-AzureADPolicy : Error occurred while executing Get-Policy 
                Code: Request_BadRequest
                Message: Invalid object identifier '`$Id' ."
            }
        } elseif (-not `$All -and `$Top) {
            `$response = `$response | Select-Object -First `$Top
        }
        
        if (`$MyInvocation.PipelineLength -gt 1) {
            `$response  
        }
        else {
            `$result = `$response 
            `$result | Select-Object * | Format-Table -AutoSize
        }    
        } 
"@
}