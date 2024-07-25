# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Connect-Entra {    
    [CmdletBinding(DefaultParameterSetName = 'UserParameterSet')]
    param (
        [Parameter(ParameterSetName = "UserParameterSet",Position = 1)]
        [System.String[]] $Scopes,
        [Parameter(ParameterSetName = "AppCertificateParameterSet",Position = 1)]
        [Parameter(ParameterSetName = "UserParameterSet")]
        [Parameter(ParameterSetName = "IdentityParameterSet")]
        [Alias("AppId", "ApplicationId")][System.String] $ClientId,
        [Parameter(ParameterSetName = "AppCertificateParameterSet")]
        [Parameter(ParameterSetName = "AppSecretCredentialParameterSet")]
        [Parameter(ParameterSetName = "UserParameterSet",Position = 4)]
        [Alias("Audience", "Tenant")][System.String] $TenantId,
        [Parameter(ParameterSetName = "AppCertificateParameterSet")]
        [Parameter(ParameterSetName = "AppSecretCredentialParameterSet")]
        [Parameter(ParameterSetName = "UserParameterSet")]
        [Parameter(ParameterSetName = "IdentityParameterSet")]
        [Parameter(ParameterSetName = "EnvironmentVariableParameterSet")]
        $ContextScope,
        [Parameter(ParameterSetName = "AppCertificateParameterSet")]
        [Parameter(ParameterSetName = "AppSecretCredentialParameterSet")]
        [Parameter(ParameterSetName = "AccessTokenParameterSet")]
        [Parameter(ParameterSetName = "UserParameterSet")]
        [Parameter(ParameterSetName = "IdentityParameterSet")]
        [Parameter(ParameterSetName = "EnvironmentVariableParameterSet")]
        [ValidateNotNullOrEmpty()]
        [Alias("EnvironmentName", "NationalCloud")][System.String] $Environment,
        [Parameter(ParameterSetName = "EnvironmentVariableParameterSet")]
        [Switch] $EnvironmentVariable,
        [Parameter(ParameterSetName = "UserParameterSet")]
        [Alias("UseDeviceAuthentication", "DeviceCode", "DeviceAuth", "Device")][System.Management.Automation.SwitchParameter] $UseDeviceCode,
        [Parameter(ParameterSetName = "AppCertificateParameterSet")]
        [Parameter(ParameterSetName = "AppSecretCredentialParameterSet")]
        [Parameter(ParameterSetName = "AccessTokenParameterSet")]
        [Parameter(ParameterSetName = "UserParameterSet")]
        [Parameter(ParameterSetName = "IdentityParameterSet")]
        [Parameter(ParameterSetName = "EnvironmentVariableParameterSet")]
        [ValidateNotNullOrEmpty()]
        [Double] $ClientTimeout,
        [Parameter()]
        [Switch] $NoWelcome,
        [Parameter(ParameterSetName = "IdentityParameterSet",Position = 1)]
        [Alias("ManagedIdentity", "ManagedServiceIdentity", "MSI")][System.Management.Automation.SwitchParameter] $Identity,
        [Parameter(ParameterSetName = "AppCertificateParameterSet",Position = 2)]
        [Alias("CertificateSubject", "CertificateName")][System.String] $CertificateSubjectName,
        [Parameter(ParameterSetName = "AppCertificateParameterSet",Position = 3)]
        [System.String] $CertificateThumbprint,
        [Parameter(ParameterSetName = "AppCertificateParameterSet")]
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate,
        [Parameter(ParameterSetName = "AppSecretCredentialParameterSet")]
        [Alias("SecretCredential", "Credential")][System.Management.Automation.PSCredential] $ClientSecretCredential,
        [Parameter(ParameterSetName = "AccessTokenParameterSet",Position = 1)]
        [System.Security.SecureString] $AccessToken
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
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
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
        Connect-MgGraph @params 
    }
}