# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDomainFederationSettings {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param(
        [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$DomainName,

        [Parameter(Mandatory=$false,Position=1,ValueFromPipelineByPropertyName=$true)]
        [System.guid] $TenantId
        ) 
    process { 
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($PSBoundParameters.ContainsKey("TenantId")) {
            $params["TenantId"] = $TenantId
        }
        if ($PSBoundParameters.ContainsKey("DomainName")) {
            $params["DomainId"] = $DomainName
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

