function Connect-Entra {    
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $false)][System.String] $TenantId,
        [Parameter(ParameterSetName = "GetById", Mandatory = $false)][System.String] $CertificateThumbprint,
        [Parameter(ParameterSetName = "GetById", Mandatory = $false)][System.String] $ApplicationId,
        [Parameter(ParameterSetName = "GetById", Mandatory = $false)][System.String] $AadAccessToken
        )

    PROCESS {    
        $params = @{}
        $keysChanged = @{}
        if ($null -ne $PSBoundParameters["TenantId"]) 
        {
            $params["TenantId"] = $PSBoundParameters["TenantId"]
        }
        if ($null -ne $PSBoundParameters["CertificateThumbprint"]) 
        {
            $params["CertificateThumbprint"] = $PSBoundParameters["CertificateThumbprint"]
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) 
        {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["AccessToken"]) 
        {
            $secureString = ConvertTo-SecureString -String $PSBoundParameters["ApplicationId"] -AsPlainText -Force
            $params["AccessToken"] = $secureString
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Connect-MgGraph @params 
        $response
    }
}