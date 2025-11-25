# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Connect-Entra {
    [CmdletBinding(DefaultParameterSetName = 'UserParameterSet', HelpUri = 'https://learn.microsoft.com/powershell/module/microsoft.entra/connect-entra')]
    param (
        [Parameter(ParameterSetName = 'UserParameterSet', Position = 1, HelpMessage = 'An array of delegated permissions to consent to.')]
        [string[]] $Scopes,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', Mandatory = $true, Position = 1, HelpMessage = 'The client ID of your application.')]
        [Parameter(ParameterSetName = 'UserParameterSet', HelpMessage = 'The client ID of your application.')]
        [Parameter(ParameterSetName = 'IdentityParameterSet', HelpMessage = 'The client ID to authenticate for a user assigned managed identity. For more information on user assigned managed identities see: https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview#how-a-user-assigned-managed-identity-works-with-an-azure-vmId. To use the SystemAssigned identity`, leave this field blank.')]
        [Alias('AppId', 'ApplicationId')]
        [string] $ClientId,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', Position = 2, HelpMessage = 'The subject distinguished name of a certificate. The Certificate will be retrieved from the current user''s certificate store.')]
        [Alias('CertificateSubject', 'CertificateName')]
        [string] $CertificateSubjectName,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', Position = 3, HelpMessage = 'The thumbprint of your certificate. The Certificate will be retrieved from the current user''s certificate store.')]
        [string] $CertificateThumbprint,

        [Parameter(ParameterSetName='AppCertificateParameterSet', HelpMessage='Include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication using given certificate.')]
        [bool] ${SendCertificateChain},

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', HelpMessage = 'An X.509 certificate supplied during invocation.')]
        [System.Security.Cryptography.X509Certificates.X509Certificate2] $Certificate,

        [Parameter(ParameterSetName = 'AppSecretCredentialParameterSet', HelpMessage = 'The PSCredential object provides the application ID and client secret for service principal credentials. For more information about the PSCredential object`, type Get-Help Get-Credential.')]
        [Alias('SecretCredential', 'Credential')]
        [pscredential] $ClientSecretCredential,

        [Parameter(ParameterSetName = 'AccessTokenParameterSet', Mandatory = $true, Position = 1, HelpMessage = 'Specifies a bearer token for Microsoft Graph service. Access tokens do timeout and you''ll have to handle their refresh.')]
        [securestring] $AccessToken,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', HelpMessage = 'The ID of the tenant to connect to. You can also use this parameter to specify your sign-in audience. i.e.`, common`, organizations`, or consumers. See https://learn.microsoft.com/entra/identity-platform/msal-client-application-configuration#authority.')]
        [Parameter(ParameterSetName = 'AppSecretCredentialParameterSet', HelpMessage = 'The ID of the tenant to connect to. You can also use this parameter to specify your sign-in audience. i.e.`, common`, organizations`, or consumers. See https://learn.microsoft.com/entra/identity-platform/msal-client-application-configuration#authority.')]
        [Parameter(ParameterSetName = 'UserParameterSet', Position = 4, HelpMessage = 'The ID of the tenant to connect to. You can also use this parameter to specify your sign-in audience. i.e.`, common`, organizations`, or consumers. See https://learn.microsoft.com/entra/identity-platform/msal-client-application-configuration#authority.')]
        [Alias('Audience', 'Tenant')]
        [string] $TenantId,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', HelpMessage = 'Determines the scope of authentication context. This accepts `Process` for the current process`, or `CurrentUser` for all sessions started by user.')]
        [Parameter(ParameterSetName = 'AppSecretCredentialParameterSet', HelpMessage = 'Determines the scope of authentication context. This accepts `Process` for the current process`, or `CurrentUser` for all sessions started by user.')]
        [Parameter(ParameterSetName = 'UserParameterSet', HelpMessage = 'Determines the scope of authentication context. This accepts `Process` for the current process`, or `CurrentUser` for all sessions started by user.')]
        [Parameter(ParameterSetName = 'IdentityParameterSet', HelpMessage = 'Determines the scope of authentication context. This accepts `Process` for the current process`, or `CurrentUser` for all sessions started by user.')]
        [Parameter(ParameterSetName = 'EnvironmentVariableParameterSet', HelpMessage = 'Determines the scope of authentication context. This accepts `Process` for the current process`, or `CurrentUser` for all sessions started by user.')]
        [Microsoft.Graph.PowerShell.Authentication.ContextScope] $ContextScope,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Parameter(ParameterSetName = 'AppSecretCredentialParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Parameter(ParameterSetName = 'AccessTokenParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Parameter(ParameterSetName = 'UserParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Parameter(ParameterSetName = 'IdentityParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Parameter(ParameterSetName = 'EnvironmentVariableParameterSet', HelpMessage = 'The name of the national cloud environment to connect to. By default global cloud is used.')]
        [Alias('EnvironmentName', 'NationalCloud')]
        [ValidateNotNullOrEmpty()] [string] $Environment,

        [Parameter(ParameterSetName = 'UserParameterSet', HelpMessage = 'Use device code authentication instead of a browser control.')]
        [Alias('UseDeviceAuthentication', 'DeviceCode', 'DeviceAuth', 'Device')]
        [switch] $UseDeviceCode,

        [Parameter(ParameterSetName = 'AppCertificateParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [Parameter(ParameterSetName = 'AppSecretCredentialParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [Parameter(ParameterSetName = 'AccessTokenParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [Parameter(ParameterSetName = 'UserParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [Parameter(ParameterSetName = 'IdentityParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [Parameter(ParameterSetName = 'EnvironmentVariableParameterSet', HelpMessage = 'Sets the HTTP client timeout in seconds.')]
        [ValidateNotNullOrEmpty()] [double] $ClientTimeout,

        [Parameter(ParameterSetName = 'IdentityParameterSet', Position = 1, HelpMessage = 'Login using a Managed Identity.')]
        [Alias('ManagedIdentity', 'ManagedServiceIdentity', 'MSI')]
        [switch] $Identity,

        [Parameter(ParameterSetName = 'EnvironmentVariableParameterSet', HelpMessage = 'Allows for authentication using environment variables configured on the host machine. See https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/identity/Azure.Identity#environment-variables.')]
        [switch] $EnvironmentVariable,

        [Parameter(HelpMessage = 'Hides the welcome message.')]
        [switch] $NoWelcome,

        [Parameter(HelpMessage = 'Wait for .NET debugger to attach')]
        [switch] $Break
    )

    begin {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.Graph.Authentication\Connect-MgGraph', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = { & $wrappedCmd @PSBoundParameters }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        }
        catch {
            throw
        }
    }

    process {
        try {
            $steppablePipeline.Process($_)
        }
        catch {
            throw
        }
    }

    end {
        try {
            $steppablePipeline.End()
        }
        catch {
            throw
        }
    }

    # clean block only supported in PowerShell v7.3+
    # clean {
    #     if ($null -ne $steppablePipeline) {
    #         $steppablePipeline.Clean()
    #     }
    # }
}
