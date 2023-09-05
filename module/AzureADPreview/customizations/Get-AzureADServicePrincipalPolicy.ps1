# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$Id = `$PSBoundParameters["Id"]
        `$params["Uri"] = "https://graph.microsoft.com/beta/serviceprincipals/`$Id/policies"
        `$params["Method"] = "GET"
        if (`$PSBoundParameters.ContainsKey("ID")) {
            `$params["Uri"] = "https://graph.microsoft.com/beta/serviceprincipals/`$Id/policies"
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
                
        `$response = (Invoke-GraphRequest -Method `$params.method -Uri `$params.uri).value   
            `$response | ForEach-Object {
                if (`$null -ne `$_) {
                    foreach (`$Keys in `$_.Keys) { 
                        `$Keys=`$Keys.SubString(0, 1).ToUpper() + `$Keys.Substring(1)
                        `$_ | Add-Member -MemberType NoteProperty -Name `$Keys -Value (`$_.`$Keys) -Force
                    }
                }
            }
            if (`$MyInvocation.PipelineLength -gt 1) {
                `$response  
            }
            else {
                `$response | Select-Object Id, DisplayName, Type, IsOrganizationDefault
            }  
    }
"@
}