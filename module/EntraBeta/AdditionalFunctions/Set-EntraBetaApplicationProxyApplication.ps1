function Set-EntraBetaApplicationProxyApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ExternalUrl,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $InternalUrl,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [String] $ExternalAuthenticationType,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $IsTranslateHostHeaderEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $IsHttpOnlyCookieEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $IsSecureCookieEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $IsPersistentCookieEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $IsTranslateLinksInBodyEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ApplicationServerTimeout,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ConnectorGroupId

    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $onPremisesPublishing = @{}
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $ObjectId = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["ExternalUrl"])
        {
            $onPremisesPublishing["externalUrl"] = $PSBoundParameters["ExternalUrl"]
        }
        if($null -ne $PSBoundParameters["InternalUrl"])
        {
            $onPremisesPublishing["internalUrl"] = $PSBoundParameters["InternalUrl"]   
        }
        if($null -ne $PSBoundParameters["ExternalAuthenticationType"])
        {
            $onPremisesPublishing["externalAuthenticationType"] = $PSBoundParameters["ExternalAuthenticationType"]
            $onPremisesPublishing["externalAuthenticationType"] = $onPremisesPublishing.externalAuthenticationType.Substring(0, 1).ToLower() + $onPremisesPublishing.externalAuthenticationType.Substring(1)
        }
        if($null -ne $PSBoundParameters["IsTranslateHostHeaderEnabled"])
        {
            $onPremisesPublishing["isTranslateHostHeaderEnabled"] = $PSBoundParameters["IsTranslateHostHeaderEnabled"]
        }
        if($null -ne $PSBoundParameters["IsHttpOnlyCookieEnabled"])
        {
            $onPremisesPublishing["isHttpOnlyCookieEnabled"] = $PSBoundParameters["IsHttpOnlyCookieEnabled"]
        }
        if($null -ne $PSBoundParameters["IsSecureCookieEnabled"])
        {
            $onPremisesPublishing["isSecureCookieEnabled"] = $PSBoundParameters["IsSecureCookieEnabled"]
        }
        if($null -ne $PSBoundParameters["IsPersistentCookieEnabled"])
        {
            $onPremisesPublishing["isPersistentCookieEnabled"] = $PSBoundParameters["IsPersistentCookieEnabled"]
        }
        if($null -ne $PSBoundParameters["IsTranslateLinksInBodyEnabled"])
        {
            $onPremisesPublishing["isTranslateLinksInBodyEnabled"] = $PSBoundParameters["IsTranslateLinksInBodyEnabled"]
        }
        if($null -ne $PSBoundParameters["ApplicationServerTimeout"])
        {
            $onPremisesPublishing["applicationServerTimeout"] = $PSBoundParameters["ApplicationServerTimeout"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
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
            web = @{ 
            redirectUris = @($ExternalUrl) 
            homePageUrl = $InternalUrl
            logoutUrl = $ExternalUrl+"?appproxy=logout"
            } 
        }
        try {
            $Application = Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId" -Method PATCH -Body $updateUrlBody
        } catch {
            Write-Error $_
            return
        }
  
        # update onpremises
        $onPremisesPublishingBody = @{onPremisesPublishing = $onPremisesPublishing}
        try {
            Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId" -Method PATCH -Body $onPremisesPublishingBody
        } catch {
            Write-Error $_
            return
        }
       
        #update connector group
        if($null -ne $PSBoundParameters["ConnectorGroupId"]){
            $ConnectorGroupId = $PSBoundParameters["ConnectorGroupId"]
            $ConnectorGroupBody = @{
                "@odata.id" = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            } 
            $ConnectorGroupBody = $ConnectorGroupBody | ConvertTo-Json
            $ConnectorGroupUri = "https://graph.microsoft.com/beta/applications/$ObjectId/connectorGroup/" + '$ref'
            try {
                $ConnectorGroup = Invoke-GraphRequest -Method PUT -Uri $ConnectorGroupUri -Body $ConnectorGroupBody -ContentType "application/json"
            } catch {
                Write-Error $_
                return
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = (Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId/onPremisesPublishing" -Method GET -Headers $customHeaders) | ConvertTo-Json -depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ObjectId -Value $ObjectId
           }
        }
        $response | Select-Object ObjectId,ExternalAuthenticationType,ApplicationServerTimeout,ExternalUrl,InternalUrl,IsTranslateHostHeaderEnabled,IsTranslateLinksInBodyEnabled,IsOnPremPublishingEnabled,VerifiedCustomDomainCertificatesMetadata,VerifiedCustomDomainKeyCredential,VerifiedCustomDomainPasswordCredential,SingleSignOnSettings,IsHttpOnlyCookieEnabled,IsSecureCookieEnabled,IsPersistentCookieEnabled

    }        
}