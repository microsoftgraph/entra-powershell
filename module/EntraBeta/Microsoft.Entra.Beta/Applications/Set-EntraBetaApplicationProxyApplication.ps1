# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Set-EntraBetaApplicationProxyApplication {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the unique identifier (ObjectId) of the Application Proxy application to update.")]
        [Alias("ObjectId")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the external URL users will use to access the application.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ExternalUrl,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the internal URL of the application within your corporate network.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $InternalUrl,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the external authentication type. Possible values: 'aadPreAuthentication'`, 'passthru'.")]
        [System.String] $ExternalAuthenticationType,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Indicates whether translation of the host header is enabled.")]
        [System.Nullable[System.Boolean]] $IsTranslateHostHeaderEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Indicates whether HTTP-only cookies are enabled for enhanced security.")]
        [System.Nullable[System.Boolean]] $IsHttpOnlyCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Indicates whether secure cookies (transmitted over HTTPS only) are enabled.")]
        [System.Nullable[System.Boolean]] $IsSecureCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Indicates whether persistent cookies (cookies that persist after browser closure) are enabled.")]
        [System.Nullable[System.Boolean]] $IsPersistentCookieEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Indicates whether translation of links in the body of responses is enabled.")]
        [System.Nullable[System.Boolean]] $IsTranslateLinksInBodyEnabled,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the timeout duration for the application server. Possible values: 'Default'`, 'Long'.")]
        [System.String] $ApplicationServerTimeout,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the connector group ID used by the Application Proxy.")]
        [System.String] $ConnectorGroupId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $onPremisesPublishing = @{}

        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $ApplicationId = $PSBoundParameters["ApplicationId"]
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

        # Update InternalUrl and ExternalUrl
        if ($ExternalUrl.EndsWith("/")) {
            $exUrl = $ExternalUrl.TrimEnd("/")
        }
        else {
            $exUrl = $ExternalUrl
        }
        $updateUrlBody = @{
            identifierUris = @($exUrl)
            web            = @{
                redirectUris = @($ExternalUrl)
                homePageUrl  = $InternalUrl
                logoutUrl    = $ExternalUrl + "?appproxy=logout"
            }
        }
        try {
            Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method PATCH -Body $updateUrlBody
        }
        catch {
            Write-Error $_
            return
        }

        # update onpremises
        $onPremisesPublishingBody = @{onPremisesPublishing = $onPremisesPublishing }
        try {
            Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method PATCH -Body $onPremisesPublishingBody
        }
        catch {
            Write-Error $_
            return
        }

        #update connector group
        if ($null -ne $PSBoundParameters["ConnectorGroupId"]) {
            $ConnectorGroupId = $PSBoundParameters["ConnectorGroupId"]
            $ConnectorGroupBody = @{
                "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            }
            $ConnectorGroupBody = $ConnectorGroupBody | ConvertTo-Json
            $ConnectorGroupUri = "/beta/applications/$ApplicationId/connectorGroup/" + '$ref'
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

        $response = (Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId/onPremisesPublishing" -Method GET -Headers $customHeaders) | ConvertTo-Json -depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType NoteProperty -Name ObjectId -Value $ApplicationId
            }
        }
        $response | Select-Object ObjectId, ExternalAuthenticationType, ApplicationServerTimeout, ExternalUrl, InternalUrl, IsTranslateHostHeaderEnabled, IsTranslateLinksInBodyEnabled, IsOnPremPublishingEnabled, VerifiedCustomDomainCertificatesMetadata, VerifiedCustomDomainKeyCredential, VerifiedCustomDomainPasswordCredential, SingleSignOnSettings, IsHttpOnlyCookieEnabled, IsSecureCookieEnabled, IsPersistentCookieEnabled
    }
}

