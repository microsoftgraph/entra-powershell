# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraBetaDomainFederationSettings {
    <#
    .SYNOPSIS
        Updates settings for a federated domain.
    
    .DESCRIPTION
        The Set-EntraBetaDomainFederationSettings cmdlet is used to update the settings of a single sign-on domain.
    
    .PARAMETER ActiveLogOnUri
        A URL that specifies the end point used by active clients when authenticating with domains set up for single sign-on (also known as identity federation) in
        Microsoft Azure Active Directory.
        
    .PARAMETER DomainName 
        The fully qualified domain name (FQDN) to update.

    .PARAMETER FederationBrandName
        The name of the string value shown to users when signing in to Microsoft Azure Active Directory. We recommend that customers use something that is familiar to
        users such as "Contoso Inc."

    .PARAMETER IssuerUri
        The unique identifier of the domain in the Microsoft Azure Active Directory Identity platform derived from the federation server.
    
    .PARAMETER LogOffUri
        The URL clients are redirected to when they sign out of Microsoft Azure Active Directory services.

    .PARAMETER MetadataExchangeUri
        The URL that specifies the metadata exchange end point used for authentication from rich client applications such as Lync Online.
    
    .PARAMETER NextSigningCertificate
        The next token signing certificate that will be used to sign tokens when the primary signing certificate expires.

    .PARAMETER PassiveLogOnUri
        The URL that web-based clients will be directed to when signing in to Microsoft Azure Active Directory services.

    .PARAMETER SigningCertificate
        The current certificate used to sign tokens passed to the Microsoft Azure Active Directory Identity platform.

    .PARAMETER TenantId
        The unique ID of the tenant to perform the operation on. If this is not provided, then the value will default to the tenant of the current user. This parameter is
        only applicable to partner users.

    .PARAMETER SupportsMfa
        Indicates whether the IDP STS supports MFA.

    .PARAMETER DefaultInteractiveAuthenticationMethod
        Indicates the default authentication method that should be used when an application requires the user to have interactive login.

    .PARAMETER OpenIdConnectDiscoveryEndpoint
        The OpenID Connect Discovery Endpoint of the federated IDP STS.

    .PARAMETER <CommonParameters>
            This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
    
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param(
            [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$DomainName,
            [Parameter(Mandatory = $false)][string]$SigningCertificate,
            [Parameter(Mandatory = $false)][string]$NextSigningCertificate,
            [Parameter(Mandatory = $false)][string]$LogOffUri,
            [Parameter(Mandatory = $false)][string]$PassiveLogOnUri,
            [Parameter(Mandatory = $false)][string]$ActiveLogOnUri,
            [Parameter(Mandatory = $false)][string]$IssuerUri,
            [Parameter(Mandatory = $false)][string]$FederationBrandName,
            [Parameter(Mandatory = $false)][string]$MetadataExchangeUri,
            [Parameter(Mandatory = $false)][string]$PreferredAuthenticationProtocol,
            [Parameter(Mandatory = $false)]$SigningCertificateUpdateStatus,
            [Parameter(Mandatory = $false)][string]$PromptLoginBehavior
            ) 
        process { 
            $params = @{}
            if($PSBoundParameters.ContainsKey("Verbose"))
            {
                $params["Verbose"] = $Null
            }
            if($null -ne $PSBoundParameters["DomainName"])
            {
                $params["DomainId"] = $PSBoundParameters["DomainName"]
                $params["InternalDomainFederationId"] = (Get-MgDomainFederationConfiguration -DomainId $DomainId).Id
            }
            if($null -ne $PSBoundParameters["SigningCertificate"])
            {
                $params["SigningCertificate"] = $PSBoundParameters["SigningCertificate"]
            }
            if($null -ne $PSBoundParameters["NextSigningCertificate"])
            {
                $params["NextSigningCertificate"] = $PSBoundParameters["NextSigningCertificate"]
            }
            if($null -ne $PSBoundParameters["LogOffUri"])
            {
                $params["SignOutUri"] = $PSBoundParameters["LogOffUri"]
            }
            if($null -ne $PSBoundParameters["PassiveLogOnUri"])
            {
                $params["PassiveSignInUri"] = $PSBoundParameters["PassiveLogOnUri"]
            }
            if($null -ne $PSBoundParameters["ActiveLogOnUri"])
            {
                $params["ActiveSignInUri"] = $PSBoundParameters["ActiveLogOnUri"]
            }
            if($null -ne $PSBoundParameters["IssuerUri"])
            {
                $params["IssuerUri"] = $PSBoundParameters["IssuerUri"]
            }
            if($null -ne $PSBoundParameters["FederationBrandName"])
            {
                $params["DisplayName"] = $PSBoundParameters["FederationBrandName"]
            }
            if($null -ne $PSBoundParameters["MetadataExchangeUri"])
            {
                $params["MetadataExchangeUri"] = $PSBoundParameters["MetadataExchangeUri"]
            }
            if($null -ne $PSBoundParameters["PreferredAuthenticationProtocol"])
            {
                $params["PreferredAuthenticationProtocol"] = $PSBoundParameters["PreferredAuthenticationProtocol"]
            }
            if($null -ne $PSBoundParameters["SigningCertificateUpdateStatus"])
            {
                $params["SigningCertificateUpdateStatus"] = $PSBoundParameters["SigningCertificateUpdateStatus"]
            }
            if($null -ne $PSBoundParameters["PromptLoginBehavior"])
            {
                $params["PromptLoginBehavior"] = $PSBoundParameters["PromptLoginBehavior"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $Null
            }
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            $response =  Update-MgBetaDomainFederationConfiguration @params
            $response
        }
    }
    
    