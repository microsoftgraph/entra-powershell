# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaApplicationProxyApplication {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the display name of the Application Proxy application.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $DisplayName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the external URL users will use to access the application.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ExternalUrl,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the internal URL of the application within your corporate network.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $InternalUrl,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the external authentication type (e.g: 'aadPreAuthentication', 'passthru').")]
        [System.String] $ExternalAuthenticationType,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Indicates whether translation of the host header is enabled.")]
        [System.Nullable[System.Boolean]] $IsTranslateHostHeaderEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Indicates whether HTTP-only cookies are enabled.")]
        [System.Nullable[System.Boolean]] $IsHttpOnlyCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Indicates whether secure cookies are enabled.")]
        [System.Nullable[System.Boolean]] $IsSecureCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Indicates whether persistent cookies are enabled.")]
        [System.Nullable[System.Boolean]] $IsPersistentCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Indicates whether translation of links in the body of responses is enabled.")]
        [System.Nullable[System.Boolean]] $IsTranslateLinksInBodyEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the timeout duration for the application server (e.g: 'Default', 'Long').")]
        [System.String] $ApplicationServerTimeout,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the connector group ID used by the Application Proxy.")]
        [System.String] $ConnectorGroupId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $onPremisesPublishing = @{}

        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $DisplayName = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["ExternalUrl"]) {
            $onPremisesPublishing["externalUrl"] = $PSBoundParameters["ExternalUrl"]
        }
        if ($null -ne $PSBoundParameters["InternalUrl"]) {
            $onPremisesPublishing["internalUrl"] = $PSBoundParameters["InternalUrl"]   
        }
        if ($null -ne $PSBoundParameters["ExternalAuthenticationType"]) {
            $onPremisesPublishing["externalAuthenticationType"] = $PSBoundParameters["ExternalAuthenticationType"]
            $onPremisesPublishing["externalAuthenticationType"] = $onPremisesPublishing.externalAuthenticationType.Substring(0, 1).ToLower() + $onPremisesPublishing.externalAuthenticationType.Substring(1)
        }
        if ($null -ne $PSBoundParameters["IsTranslateHostHeaderEnabled"]) {
            $onPremisesPublishing["isTranslateHostHeaderEnabled"] = $PSBoundParameters["IsTranslateHostHeaderEnabled"]
        }
        if ($null -ne $PSBoundParameters["IsHttpOnlyCookieEnabled"]) {
            $onPremisesPublishing["isHttpOnlyCookieEnabled"] = $PSBoundParameters["IsHttpOnlyCookieEnabled"]
        }
        if ($null -ne $PSBoundParameters["IsSecureCookieEnabled"]) {
            $onPremisesPublishing["isSecureCookieEnabled"] = $PSBoundParameters["IsSecureCookieEnabled"]
        }
        if ($null -ne $PSBoundParameters["IsPersistentCookieEnabled"]) {
            $onPremisesPublishing["isPersistentCookieEnabled"] = $PSBoundParameters["IsPersistentCookieEnabled"]
        }
        if ($null -ne $PSBoundParameters["IsTranslateLinksInBodyEnabled"]) {
            $onPremisesPublishing["isTranslateLinksInBodyEnabled"] = $PSBoundParameters["IsTranslateLinksInBodyEnabled"]
        }
        if ($null -ne $PSBoundParameters["ApplicationServerTimeout"]) {
            $onPremisesPublishing["applicationServerTimeout"] = $PSBoundParameters["ApplicationServerTimeout"]
        }        

        #Create New App
        $newAppBody = @{
            displayName = $DisplayName
        } | ConvertTo-Json
        try {
            $NewApp = Invoke-GraphRequest -Uri '/beta/applications' -Method POST -Body $newAppBody
            $Id = $NewApp.Id
        }
        catch {
            Write-Error $_
            return
        }
        
        # Update InternalUrl and ExternalUrl
        if ($null -ne $NewApp) {
            if ($ExternalUrl.EndsWith("/")) {
                $exUrl = $ExternalUrl.TrimEnd("/")
            }
            else {
                $exUrl = $ExternalUrl
            }
            $UpdateUrlBody = @{ 
                identifierUris = @($exUrl) 
                web            = @{ 
                    redirectUris = @($ExternalUrl) 
                    homePageUrl  = $InternalUrl 
                } 
            } 
            try {
                Invoke-GraphRequest -Uri "/beta/applications/$Id" -Method PATCH -Body $updateUrlBody    
            }
            catch {
                Write-Error $_
                return
            }
        }
        
        # Create ServicePrincipal
        if ($null -ne $NewApp) {
            $serviceBody = @{
                appId = $NewApp.AppId
            } | ConvertTo-Json
            try {
                $ServicePrincipal = Invoke-GraphRequest -Uri "/beta/servicePrincipals" -Method POST -Body $serviceBody    
            }
            catch {
                Write-Error $_
                return
            }
        }
        
        # update onpremises
        if ($null -ne $ServicePrincipal -and $null -ne $NewApp) {
            $onPremisesPublishingBody = @{onPremisesPublishing = $onPremisesPublishing }
            try {
                Invoke-GraphRequest -Uri "/beta/applications/$Id" -Method PATCH -Body $onPremisesPublishingBody
            }
            catch {
                Write-Error $_
                return
            }
        }
       
        #update connector group
        if ($null -ne $PSBoundParameters["ConnectorGroupId"] -and $null -ne $NewApp) {
            $ConnectorGroupId = $PSBoundParameters["ConnectorGroupId"]
            $ConnectorGroupBody = @{
                "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            } 
            $ConnectorGroupBody = $ConnectorGroupBody | ConvertTo-Json
            $ConnectorGroupUri = "/beta/applications/$Id/connectorGroup/" + '$ref'
            try {
                Invoke-GraphRequest -Method PUT -Uri $ConnectorGroupUri -Body $ConnectorGroupBody -ContentType "application/json" 
            }
            catch {
                Write-Error $_
                return
            }
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = (Invoke-GraphRequest -Uri "/beta/applications/$Id/onPremisesPublishing" -Headers $customHeaders -Method GET) | ConvertTo-Json -depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType NoteProperty -Name ObjectId -Value $Id
            }
        }
        
        $response = $response | Select-Object ObjectId, ExternalAuthenticationType, ApplicationServerTimeout, ExternalUrl, InternalUrl, IsTranslateHostHeaderEnabled, IsTranslateLinksInBodyEnabled, IsOnPremPublishingEnabled, VerifiedCustomDomainCertificatesMetadata, VerifiedCustomDomainKeyCredential, VerifiedCustomDomainPasswordCredential, SingleSignOnSettings, IsHttpOnlyCookieEnabled, IsSecureCookieEnabled, IsPersistentCookieEnabled | ConvertTo-Json -depth 10 | ConvertFrom-Json
            
        $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphonPremisesPublishing
        $response.PSObject.Properties | ForEach-Object {
            $propertyName = $_.Name
            $propertyValue = $_.Value
            $respType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
        
        }
        
        $respType
    }        
}

