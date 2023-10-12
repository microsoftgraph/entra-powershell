# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADGroupAppRoleAssignment "
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$keysChanged = @{ObjectId = "Id"}
        if(`$null -ne `$PSBoundParameters["ResourceId"])
        {
            `$params["ResourceId"] = `$PSBoundParameters["ResourceId"]
        }
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$params["Id"] = `$PSBoundParameters["Id"]
        }
        if(`$null -ne `$PSBoundParameters["ObjectId"])
        {
            `$params["GroupId"] = `$PSBoundParameters["ObjectId"]
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["PrincipalId"])
        {
            `$params["PrincipalId"] = `$PSBoundParameters["PrincipalId"]
        }
        `$params["BodyParameter"] = @{
           "principalId" = `$params.PrincipalId
           "resourceId" = `$params.ResourceId
           "appRoleId" = `$params.Id
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = New-MgBetaGroupAppRoleAssignment @params 
        `$response
        }
"@
}