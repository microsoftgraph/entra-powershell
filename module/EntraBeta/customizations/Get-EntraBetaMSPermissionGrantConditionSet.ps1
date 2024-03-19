# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSPermissionGrantConditionSet"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    `$params = @{}
    `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
    if(`$PSBoundParameters.ContainsKey("Verbose"))
    {
        `$params["Verbose"] = `$Null
    }
    if(`$null -ne `$PSBoundParameters["Id"])
    {
        `$params["PermissionGrantConditionSetId"] = `$PSBoundParameters["Id"]
    }
    if(`$null -ne `$PSBoundParameters["ConditionSetType"])
    {
        `$conditionalSet = `$PSBoundParameters["ConditionSetType"]
    }
    if(`$null -ne `$PSBoundParameters["PolicyId"])
    {
        `$params["PermissionGrantPolicyId"] = `$PSBoundParameters["PolicyId"]
    }
    if(`$PSBoundParameters.ContainsKey("Debug"))
    {
        `$params["Debug"] = `$Null
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $`params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
    Write-Debug("=========================================================================``n")
    
    if("`$conditionalSet" -eq "includes"){
        `$response = Get-MgBetaPolicyPermissionGrantPolicyInclude @params -Headers $customHeaders
    }
    elseif("`$conditionalSet" -eq "excludes"){
        `$response = Get-MgBetaPolicyPermissionGrantPolicyExclude @params -Headers $customHeaders
    }
    else{
        Write-Error("Message: Resource not found for the segment '`$conditionalSet'.")
        return
    }
    
    `$response
"@
}