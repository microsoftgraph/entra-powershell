# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADGroupAppRoleAssignment"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$keysChanged = @{ObjectId = "Id"}
        `$body=@{}
        if(`$null -ne `$PSBoundParameters["ResourceId"])
        {
            `$body["ResourceId"] = `$PSBoundParameters["ResourceId"]
        }
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$body["AppRoleId"] = `$PSBoundParameters["Id"]
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
            `$body["PrincipalId"] = `$PSBoundParameters["PrincipalId"]
        }
        `$params["BodyParameter"] = @{
           "principalId" = `$body.PrincipalId
           "resourceId" = `$body.ResourceId
           "appRoleId" = `$body.AppRoleId
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================
")
        
        `$response = New-MgBetaGroupAppRoleAssignment @params 
        `$customTable = [PSCustomObject]@{
            "ObjectId" = `$response.Id
            "ObjectType"      = "AppRoleAssignment"
            "CreationTimestamp" = `$response.AppRoleAssignment
            "Id" = `$response.AppRoleId
            "PrincipalDisplayName" = `$response.PrincipalDisplayName
            "PrincipalId" = `$response.PrincipalDisplayName
            "PrincipalType" = `$response.PrincipalType
            "ResourceDisplayName" = `$response.ResourceDisplayName
            "ResourceId" = `$response.ResourceId
            "AdditionalProperties" = `$response.AdditionalProperties
        }
        `$customTable 
        }  
"@
}