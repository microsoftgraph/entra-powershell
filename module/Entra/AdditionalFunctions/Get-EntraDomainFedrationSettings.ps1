# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDomainFedrationSettings {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param(
        [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName=$true)][string]$DomainName,
        [Parameter(Mandatory=$false,Position=1,ValueFromPipelineByPropertyName=$true)][ValidateNotNullOrEmpty()][ValidateScript({ if ($_ -is [System.Guid]) { $true } else { throw "TenantId must be of type [System.Guid]." } })][System.guid] $TenantId
        ) 
    process { 
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
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
        $response =  Get-MgDomainFederationConfiguration -Headers $customHeaders -DomainId $params["DomainId"] | ConvertTo-Json -Depth 10 | ConvertFrom-Json 
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
        $customTable 

    }
}

