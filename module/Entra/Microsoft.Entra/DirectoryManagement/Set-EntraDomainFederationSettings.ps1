# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraDomainFederationSettings {
        [CmdletBinding(DefaultParameterSetName = 'Default')]
        param(
            [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$DomainName,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$SigningCertificate,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$NextSigningCertificate,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$LogOffUri,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$PassiveLogOnUri,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$ActiveLogOnUri,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$IssuerUri,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$FederationBrandName,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$MetadataExchangeUri,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$PreferredAuthenticationProtocol,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]$SigningCertificateUpdateStatus,
            [Parameter(Mandatory = $false,ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string]$PromptLoginBehavior
        )
        
        begin {
            # Ensure connection to Microsoft Entra
            if (-not (Get-EntraContext)) {
                $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Domain.ReadWrite.All' to authenticate."
                Write-Error -Message $errorMessage -ErrorAction Stop
                return
            }
        }

        process { 
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            if($PSBoundParameters.ContainsKey("Verbose"))
            {
                $params["Verbose"] = $PSBoundParameters["Verbose"]
            }
            if($null -ne $PSBoundParameters["DomainName"])
            {
                $params["DomainId"] = $PSBoundParameters["DomainName"]
                $Id = $PSBoundParameters["DomainName"]
                if($null -ne $Id)
                {
                    $params["InternalDomainFederationId"] = (Get-MgDomainFederationConfiguration -DomainId $Id).Id
                }
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
            if($null -ne $params.InternalDomainFederationId)
            {
                $response =  Update-MgDomainFederationConfiguration @params -Headers $customHeaders
                $response
            }
        }
    }

