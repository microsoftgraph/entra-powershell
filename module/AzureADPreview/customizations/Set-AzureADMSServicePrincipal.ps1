# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSServicePrincipal"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$body = @{}
        `$keysChanged = @{ObjectId = "Id"}
        if(`$null -ne `$PSBoundParameters["AccountEnabled"])
        {
            `$body["AccountEnabled"] = `$PSBoundParameters["AccountEnabled"]
        }
        if(`$null -ne `$PSBoundParameters["Tags"])
        {
            `$body["Tags"] = `$PSBoundParameters["Tags"]
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["DisplayName"])
        {
            `$body["DisplayName"] = `$PSBoundParameters["DisplayName"]
        }
        if(`$null -ne `$PSBoundParameters["AppId"])
        {
            `$body["AppId"] = `$PSBoundParameters["AppId"]
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["ErrorUrl"])
        {
            `$params["ErrorUrl"] = `$PSBoundParameters["ErrorUrl"]
        }
        if(`$null -ne `$PSBoundParameters["KeyCredentials"])
        {
            `$params["KeyCredentials"] = `$PSBoundParameters["KeyCredentials"]
        }
        if(`$null -ne `$PSBoundParameters["ReplyUrls"])
        {
            `$params["ReplyUrls"] = `$PSBoundParameters["ReplyUrls"]
        }
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$params["ServicePrincipalId"] = `$PSBoundParameters["Id"]
        }
        if(`$null -ne `$PSBoundParameters["LogoutUrl"])
        {
            `$params["LogoutUrl"] = `$PSBoundParameters["LogoutUrl"]
        }
        if(`$null -ne `$PSBoundParameters["SamlMetadataUrl"])
        {
            `$params["SamlMetadataUrl"] = `$PSBoundParameters["SamlMetadataUrl"]
        }
        if(`$null -ne `$PSBoundParameters["Homepage"])
        {
            `$params["Homepage"] = `$PSBoundParameters["Homepage"]
        }
        if(`$null -ne `$PSBoundParameters["AppRoleAssignmentRequired"])
        {
            `$body["AppRoleAssignmentRequired"] = `$PSBoundParameters["AppRoleAssignmentRequired"]
        }
        if(`$null -ne `$PSBoundParameters["PasswordCredentials"])
        {
            `$params["PasswordCredentials"] = `$PSBoundParameters["PasswordCredentials"]
        }
        if(`$null -ne `$PSBoundParameters["PublisherName"])
        {
            `$params["PublisherName"] = `$PSBoundParameters["PublisherName"]
        }
        if(`$null -ne `$PSBoundParameters["ServicePrincipalNames"])
        {
            `$body["ServicePrincipalNames"] = `$PSBoundParameters["ServicePrincipalNames"]
        }
        if(`$null -ne `$PSBoundParameters["PreferredTokenSigningKeyThumbprint"])
        {
            `$body["PreferredTokenSigningKeyThumbprint"] = `$PSBoundParameters["PreferredTokenSigningKeyThumbprint"]
        }
        if(`$body.Count -gt 0)
        {
            `$params["BodyParameter"] = `$body
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Update-MgBetaServicePrincipal @params
        `$response | ForEach-Object {
            if(`$null -ne `$_) {
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        `$response
        }
"@
}