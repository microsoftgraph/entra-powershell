function New-EntraBetaApplicationProxyApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $DisplayName,
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
    [System.Nullable`1[System.Boolean]] $ApplicationServerTimeout,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ConnectorGroupId

    )

    PROCESS {    
        $params = @{}
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $DisplayName = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["ExternalUrl"])
        {
            
        }
        if($null -ne $PSBoundParameters["InternalUrl"])
        {
            
        }
        if($null -ne $PSBoundParameters["ExternalAuthenticationType"])
        {
           
        }
        if($null -ne $PSBoundParameters["IsTranslateHostHeaderEnabled"])
        {
           
        }
        if($null -ne $PSBoundParameters["IsHttpOnlyCookieEnabled"])
        {
           
        }
        if($null -ne $PSBoundParameters["IsSecureCookieEnabled"])
        {
           
        }
        if($null -ne $PSBoundParameters["IsPersistentCookieEnabled"])
        {
           
        }
        if($null -ne $PSBoundParameters["IsTranslateLinksInBodyEnabled"])
        {
           
        }
        if($null -ne $PSBoundParameters["ApplicationServerTimeout"])
        {
           
        }
        if($null -ne $PSBoundParameters["ConnectorGroupId"])
        {
           
        }

        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }

        $newAppBody = @{
            displayName =  $DisplayName
        } | ConvertTo-Json
        $NewApp = Invoke-GraphRequest -Uri 'https://graph.microsoft.com/v1.0/applications' -Method POST -Body $newAppBody
        $Id = $NewApp.Id

        #Update InternalUrl and ExternalUrl
        $UpdateUrlBody = @{ 
            identifierUris = @($ExternalUrl) 
            web = @{ 
            redirectUris = @($ExternalUrl) 
            homePageUrl = $InternalUrl 
            } 
        } 
        Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$Id" -Method PATCH -Body $updateUrlBody

        #Create ServicePrincipal
        $serviceBody = @{
            appId = $NewApp.AppId
        } | ConvertTo-Json
        Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/servicePrincipals" -Method POST -Body $serviceBody

        
            

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }        
}