# -----------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# -----------------------------------------------------------------------------
@{
    SourceName   = "Add-AzureADApplicationPolicy"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @"
    PROCESS {        
        `$params = @{}
        `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
        `$keysChanged = @{}
        if (`$PSBoundParameters.ContainsKey("Debug")) {
            `$params["Debug"] = `$Null
        }
        if (`$null -ne `$PSBoundParameters["ID"]) {
            `$id = `$PSBoundParameters["ID"]
        }
        if (`$null -ne `$PSBoundParameters["RefObjectId"]) {
            `$RefObjectId = `$PSBoundParameters["RefObjectId"]
        }
        if (`$PSBoundParameters.ContainsKey("Verbose")) {
            `$params["Verbose"] = `$Null
        }

        `$uri = "https://graph.microsoft.com/beta/applications/`$id/Policies/" + '`$ref'
        `$body = @{
            "@odata.id" = "https://graph.microsoft.com/beta/legacy/policies/`$RefObjectId"
        }
        `$body = `$body | ConvertTo-Json

        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$response = Invoke-MgGraphRequest -Headers `$customHeaders -Method POST -Uri `$uri -Body `$body -ContentType "application/json"
        `$response
    }
"@
}
        