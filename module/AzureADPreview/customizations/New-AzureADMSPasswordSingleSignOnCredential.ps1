# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSPasswordSingleSignOnCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    `$params = @{}
    if(`$null -ne `$PSBoundParameters["ObjectId"])
    {
        `$params["ServicePrincipalId"] = `$PSBoundParameters["ObjectId"]
    }
    if(`$null -ne `$PSBoundParameters["PasswordSSOCredential"])
    {
        `$body = [PasswordSSOCredentials]`$PSBoundParameters["PasswordSSOCredential"] | ConvertTo-Json
    }
    `$headers = @{
        "Content-Type" = "application/json"
    }
    `$params["Uri"] = "https://graph.microsoft.com/beta/serviceprincipals/"+`$params.ServicePrincipalId+"/getPasswordSingleSignOnCredentials"
    `$params["Method"] = "POST"

    if(`$PSBoundParameters.ContainsKey("Debug"))
    {
        `$params["Debug"] = `$Null
    }
    if(`$PSBoundParameters.ContainsKey("Verbose"))
    {
        `$params["Verbose"] = `$Null
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    `$response = Invoke-GraphRequest -Uri `$params.uri -Method `$params.method -Headers `$headers -Body `$body | ConvertTo-Json
    `$result = `$response | ConvertFrom-Json      
    `$result | Add-Member -MemberType AliasProperty -Value '@odata.context' -Name 'odata.context' -Force
    `$result
"@
}