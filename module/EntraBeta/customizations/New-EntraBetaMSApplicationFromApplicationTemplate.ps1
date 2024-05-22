# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------
@{
    SourceName   = "New-AzureADMSApplicationFromApplicationTemplate"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{$Id = "ApplicationTemplateId" }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["ApplicationTemplateId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["displayName"] = ($PSBoundParameters["displayName"]).displayname
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-MgBetaInstantiateApplicationTemplate @params -Headers $customHeaders
        $Application = [PSCustomObject]@{
            "ObjectId"                = ($response.Application | select-object -ExpandProperty AdditionalProperties)["objectId"]
            "ApplicationTemplateId"   = ($response.Application | select-object -ExpandProperty AdditionalProperties)["applicationTemplateId"]
            "AppId"                   = ($response.Application).AppId
            "DisplayName"             = ($response.Application).DisplayName
            "Homepage"                = ($response.Application | select-object -ExpandProperty AdditionalProperties)["homepage"]
            "IdentifierUris"          = ($response.Application).IdentifierUris
            "PublicClient"            = ($response.Application).PublicClient.RedirectUris
            "ReplyUrls"               = ($response.Application | select-object -ExpandProperty AdditionalProperties)["replyUrls"]
            "LogoutUrl"               = ($response.Application | select-object -ExpandProperty web).LogoutUrl
            "GroupMembershipClaims"   = ($response.Application).GroupMembershipClaims
            "AvailableToOtherTenants" = ($response.Application | select-object -ExpandProperty AdditionalProperties)["availableToOtherTenants"]
        }
       $ServicePrincipal = [PSCustomObject]@{
            "Id"                        = ($response.ServicePrincipal).Id
            "ObjectId"                  = ($response.ServicePrincipal | select-object -ExpandProperty AdditionalProperties)["objectId"]
            "AccountEnabled"            = ($response.ServicePrincipal).AccountEnabled
            "AppDisplayName"            = ($response.ServicePrincipal).AppDisplayName
            "ApplicationTemplateId"     = ($response.ServicePrincipal | select-object -ExpandProperty AdditionalProperties)["applicationTemplateId"]
            "AppId"                     = ($response.ServicePrincipal).AppId
            "AppRoleAssignmentRequired" = ($response.ServicePrincipal).AppRoleAssignmentRequired
            "CustomSecurityAttributes"  = ($response.ServicePrincipal).CustomSecurityAttributes
            "DisplayName"               = ($response.ServicePrincipal).DisplayName
            "ErrorUrl"                  = ($response.ServicePrincipal).ErrorUrl
            "LogoutUrl"                 = ($response.ServicePrincipal).LogoutUrl 
            "Homepage"                  = ($response.ServicePrincipal).Homepage
            "SamlMetadataUrl"           = ($response.ServicePrincipal).SamlMetadataUrl
            "PublisherName" = ($response.ServicePrincipal).PublisherName
            "PreferredTokenSigningKeyThumbprint" = ($response.ServicePrincipal).PreferredTokenSigningKeyThumbprint
            "ReplyUrls" = ($response.ServicePrincipal).ReplyUrls
            "Tags" = ($response.ServicePrincipal).Tags
            "ServicePrincipalNames" = ($response.ServicePrincipal).ServicePrincipalNames
            "KeyCredentials" =  ($response.ServicePrincipal).KeyCredentials
            "PasswordCredentials" = ($response.ServicePrincipal).PasswordCredentials
            "IdentifierUris"            = ($response.Application).IdentifierUris
            "PublicClient"              = ($response.Application).PublicClient.RedirectUris
            "GroupMembershipClaims"     = ($response.Application).GroupMembershipClaims
            "AvailableToOtherTenants"   = ($response.Application | select-object -ExpandProperty AdditionalProperties)["availableToOtherTenants"]
        }
        $re = [PSCustomObject]@{
            "application"     = $Application
            "serviceprincipal" = $ServicePrincipal
        }
        $re
    } 
'@
}