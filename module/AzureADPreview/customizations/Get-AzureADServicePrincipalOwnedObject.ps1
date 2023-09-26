# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADServicePrincipalOwnedObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    `$params = @{}
    `$keysChanged = @{ObjectId = "Id"}
    if(`$PSBoundParameters.ContainsKey("Verbose"))
    {
        `$params["Verbose"] = `$Null
    }
    if(`$null -ne `$PSBoundParameters["ObjectId"])
    {
        `$params["ServicePrincipalID"] = `$PSBoundParameters["ObjectId"]
    }
    if(`$PSBoundParameters["All"])
    {
        `$params["All"] = `$PSBoundParameters["All"]
    }
    if(`$PSBoundParameters.ContainsKey("Debug"))
    {
        `$params["Debug"] = `$Null
    }
    if(`$null -ne `$PSBoundParameters["Top"])
    {
        `$params["Top"] = `$PSBoundParameters["Top"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    `$response = Get-MgBetaServicePrincipalOwnedObject @params
    `$OutputData = (`$response).Additionalproperties | ConvertTo-Json | ConvertFrom-Json
     Add-Member -InputObject `$OutputData -NotePropertyName DeletionTimestamp -NotePropertyValue `$response.DeletedDateTime
     Add-Member -InputObject `$OutputData -NotePropertyName ObjectId -NotePropertyValue `$response.Id
    `$OutputData
"@
}
