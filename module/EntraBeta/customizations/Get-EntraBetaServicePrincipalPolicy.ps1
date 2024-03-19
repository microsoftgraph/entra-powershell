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
        `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
                if (`$null -ne `$PSBoundParameters["Id"]) {
                    `$params["Id"] = `$PSBoundParameters["Id"]
                }
                `$Method = "GET"
                if (`$PSBoundParameters.ContainsKey("Debug")) {
                    `$params["Debug"] = `$Null
                }
                if (`$PSBoundParameters.ContainsKey("Verbose")) {
                    `$params["Verbose"] = `$Null
                }
                    Write-Debug("============================ TRANSFORMATIONS ============================")
                    `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
                    Write-Debug("=========================================================================``n")
                    `$URI = "https://graph.microsoft.com/beta/serviceprincipals/`$Id/policies"
                    `$response = (Invoke-GraphRequest -Headers `$customHeaders -Uri `$uri -Method `$Method | ConvertTo-Json | ConvertFrom-Json).value
                    `$response | Add-Member -MemberType AliasProperty -Value '@odata.type' -Name 'odata.type'
                    `$response
            }
"@
}