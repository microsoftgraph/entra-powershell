function Connect-Entra {    
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter()][System.String[]] $Scopes,
        [Parameter()][Alias("AppId", "ApplicationId")][System.String] $ClientId,
        [Parameter()][Alias("Audience", "Tenant")][System.String] $TenantId,
        [Parameter()] $ContextScope,
        [Parameter()][Alias("EnvironmentName", "NationalCloud")][System.String] $Environment,
        [Parameter()][Switch] $EnvironmentVariable,
        [Parameter()][Alias("UseDeviceAuthentication", "DeviceCode", "DeviceAuth", "Device")][System.Management.Automation.SwitchParameter] $UseDeviceCode,
        [Parameter()][Double] $ClientTimeout,
        [Parameter()][Switch] $NoWelcome,
        [Parameter()][Alias("ManagedIdentity", "ManagedServiceIdentity", "MSI")][System.Management.Automation.SwitchParameter] $Identity,
        [Parameter()][Alias("CertificateSubject", "CertificateName")][System.String] $CertificateSubjectName,
        [Parameter()][System.String] $CertificateThumbprint,
        [Parameter()][System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate,
        [Parameter()][Alias("SecretCredential", "Credential")][System.Management.Automation.PSCredential] $ClientSecretCredential,
        [Parameter()][System.Security.SecureString] $AccessToken
        )

    PROCESS {    
        $params = @{}
        $keysChanged = @{}
        if ($null -ne $PSBoundParameters["Scopes"]) {
            $params["Scopes"] = $PSBoundParameters["Scopes"]
        }
        
        if ($null -ne $PSBoundParameters["ClientId"]) {
            $params["ClientId"] = $PSBoundParameters["ClientId"]
        }
        
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["TenantId"] = $PSBoundParameters["TenantId"]
        }
        
        if ($null -ne $PSBoundParameters["ContextScope"]) {
            $params["ContextScope"] = $PSBoundParameters["ContextScope"]
        }
        
        if ($null -ne $PSBoundParameters["Environment"]) {
            $params["Environment"] = $PSBoundParameters["Environment"]
        }

        if ($PSBoundParameters.ContainsKey("EnvironmentVariable")) {
            $params["EnvironmentVariable"] = $PSBoundParameters["EnvironmentVariable"]
        }
        
        if ($null -ne $PSBoundParameters["UseDeviceCode"]) {
            $params["UseDeviceCode"] = $PSBoundParameters["UseDeviceCode"]
        }
        
        if ($null -ne $PSBoundParameters["ClientTimeout"]) {
            $params["ClientTimeout"] = $PSBoundParameters["ClientTimeout"]
        }
        
        if ($PSBoundParameters.ContainsKey("NoWelcome")) {
            $params["NoWelcome"] = $PSBoundParameters["NoWelcome"]
        }
        
        if ($PSBoundParameters.ContainsKey("Identity")) {
            $params["Identity"] = $PSBoundParameters["Identity"]
        }
        
        if ($null -ne $PSBoundParameters["CertificateSubjectName"]) {
            $params["CertificateSubjectName"] = $PSBoundParameters["CertificateSubjectName"]
        }
        
        if ($null -ne $PSBoundParameters["CertificateThumbprint"]) {
            $params["CertificateThumbprint"] = $PSBoundParameters["CertificateThumbprint"]
        }
        
        if ($null -ne $PSBoundParameters["Certificate"]) {
            $params["Certificate"] = $PSBoundParameters["Certificate"]
        }
        
        if ($null -ne $PSBoundParameters["ClientSecretCredential"]) {
            $params["ClientSecretCredential"] = $PSBoundParameters["ClientSecretCredential"]
        }
        
        if ($null -ne $PSBoundParameters["AccessToken"]) {
            $params["AccessToken"] = $PSBoundParameters["AccessToken"]
        }
        
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
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
        }di
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        Connect-MgGraph @params 
    }
}