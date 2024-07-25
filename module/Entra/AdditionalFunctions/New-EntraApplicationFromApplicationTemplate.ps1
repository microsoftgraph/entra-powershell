# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraApplicationFromApplicationTemplate {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $DisplayName
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["ApplicationTemplateId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
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

        $body = @{
            displayName = $DisplayName
        }

        $uri = "https://graph.microsoft.com/v1.0/applicationTemplates/$Id/instantiate"
        $response =  invoke-graphrequest -uri $uri -Headers $customHeaders -Body $body -Method POST
        $Application = [PSCustomObject]@{
            "Id"                      = ($response.Application).id
            "ObjectId"                = ($response.Application).id
            "ApplicationTemplateId"   = ($response.Application).applicationTemplateId
            "AppId"                   = ($response.Application).AppId
            "DisplayName"             = ($response.Application).DisplayName
            "Homepage"                = $response.Application.web.homePageUrl
            "IdentifierUris"          = ($response.Application).IdentifierUris
            "PublicClient"            = ($response.Application).PublicClient.RedirectUris            
            "LogoutUrl"               = $response.Application.web.LogoutUrl
            "GroupMembershipClaims"   = ($response.Application).GroupMembershipClaims
        }
        $ServicePrincipal = [PSCustomObject]@{
            "Id"                        = ($response.ServicePrincipal).Id
            "ObjectId"                  = ($response.ServicePrincipal).Id
            "AccountEnabled"            = ($response.ServicePrincipal).AccountEnabled
            "AppDisplayName"            = ($response.ServicePrincipal).AppDisplayName
            "ApplicationTemplateId"     = ($response.ServicePrincipal).applicationTemplateId
            "AppId"                     = ($response.ServicePrincipal).AppId
            "AppRoleAssignmentRequired" = ($response.ServicePrincipal).AppRoleAssignmentRequired            
            "DisplayName"               = ($response.ServicePrincipal).DisplayName            
            "LogoutUrl"                 = ($response.ServicePrincipal).LogoutUrl 
            "Homepage"                  = ($response.ServicePrincipal).Homepage
            "PublisherName"             = ($response.ServicePrincipal).verifiedPublisher.displayName
            "PreferredTokenSigningKeyThumbprint" = ($response.ServicePrincipal).PreferredTokenSigningKeyThumbprint
            "ReplyUrls" = ($response.ServicePrincipal).ReplyUrls
            "Tags" = ($response.ServicePrincipal).Tags
            "ServicePrincipalNames" = ($response.ServicePrincipal).ServicePrincipalNames
            "KeyCredentials" =  ($response.ServicePrincipal).KeyCredentials
            "PasswordCredentials" = ($response.ServicePrincipal).PasswordCredentials
            "IdentifierUris"            = ($response.Application).IdentifierUris
            "PublicClient"              = ($response.Application).PublicClient.RedirectUris
            "GroupMembershipClaims"     = ($response.Application).GroupMembershipClaims
        }
        $re = [PSCustomObject]@{
            "application"     = $Application
            "serviceprincipal" = $ServicePrincipal
        }
        $re
    }     
}