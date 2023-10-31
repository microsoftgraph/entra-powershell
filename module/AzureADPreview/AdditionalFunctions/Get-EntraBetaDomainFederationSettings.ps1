# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaDomainFederationSettings {
    <#
    .SYNOPSIS
        Retrieves settings for a federated domain.
    .DESCRIPTION
        The Get-EntraBetaDomainFederationSettings cmdlet gets key settings from Microsoft Azure Active Directory. Use the Get-EntraFederationProperty cmdlet to get settings for both Microsoft Azure Active Directory and the Active Directory Federation Services server.
    .PARAMETER DomainName
        The fully qualified domain name to retrieve.
        
    .PARAMETER TenantId 
        The unique ID of the tenant to perform the operation on. If this is not provided then the value will default to the tenant of the current user. This parameter is only applicable to partner users.
    .PARAMETER <CommonParameters>
            This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable and OutVariable. For more information, see about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
        
    .OUTPUTS
        Microsoft.Online.Administration.DomainFederationSettings
        This cmdlet returns the following settings:
        
                ActiveLogOnUri
                FederationBrandName
                IssuerUri
                LogOffUri
                MetadataExchangeUri
                NextSigningCertificate
                PassiveLogOnUri
                SigningCertificate
    .EXAMPLE
        
    C:\PS>Get-EntraBetaDomainFederationSettings -DomainName contoso.com
        
        Returns the federation settings for contoso.com.
        Description
        
        -----------
        
        Returns the federation settings for contoso.com.
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param(
            [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName=$true)][string]$DomainName,
            [Parameter(Mandatory=$false,Position=1,ValueFromPipelineByPropertyName=$true)][ValidateNotNullOrEmpty()][ValidateScript({ if ($_ -is [System.Guid]) { $true } else { throw "TenantId must be of type [System.Guid]." } })][System.guid] $TenantId
            ) 
        process { 
            $params = @{}
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $Verbose = $Null
            }
            if ($PSBoundParameters.ContainsKey("TenantId")) {
                $params["TenantId"] = $TenantId
            }
            if ($PSBoundParameters.ContainsKey("DomainName")) {
                $params["DomainId"] = $DomainName
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $Null
            }
    
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            $response =  Get-MgBetaDomainFederationConfiguration -DomainId $params["DomainId"] | ConvertTo-Json -Depth 10 | ConvertFrom-Json 
            $customTable = [PSCustomObject]@{
                "ActiveLogOnUri"      = $response.ActiveSignInUri
                #"DefaultInteractiveAuthenticationMethod" = $response.
                "FederationBrandName" = $response.DisplayName
                "IssuerUri" = $response.IssuerUri
                "LogOffUri" = $response.SignOutUri
                "MetadataExchangeUri" = $response.MetadataExchangeUri
                "NextSigningCertificate" = $response.NextSigningCertificate
                #"OpenIdConnectDiscoveryEndpoint" = $response.
                "PassiveLogOnUri" = $response.PassiveSignInUri
                #"PasswordChangeUri" = $response.
                #"PasswordResetUri" = $response.
                "PreferredAuthenticationProtocol" = $response.PreferredAuthenticationProtocol
                "PromptLoginBehavior" = $response.PromptLoginBehavior
                "SigningCertificate" = $response.SigningCertificate
                "SigningCertificateUpdateStatus" = $response.SigningCertificateUpdateStatus
                #"SupportsMfa" = $response.
            }
            if($null -ne $response)
            {
                $customTable   
            }
        }
    }
    