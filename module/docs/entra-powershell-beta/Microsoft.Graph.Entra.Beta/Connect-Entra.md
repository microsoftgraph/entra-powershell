---
title: Connect-Entra
description: This article provides details on the Connect-Entra Command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi254
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Connect-Entra

## SYNOPSIS
Connects with an authenticated account to use Microsoft Entra ID cmdlet requests.

## SYNTAX

### UserParameterSet (Default)
```powershell
Connect-Entra 
[[-Scopes] <String[]>] 
[[-ClientId] <String>] 
[-TenantId <String>]
 [-ContextScope <ContextScope>] 
 [-Environment <String>] 
 [-UseDeviceCode] 
 [-ClientTimeout <Double>] 
 [-NoWelcome]
 [<CommonParameters>]
```

### AppCertificateParameterSet
```powershell
Connect-Entra 
[-ClientId] <String> 
[[-CertificateSubjectName] <String>] 
[[-CertificateThumbprint] <String>]
[-Certificate <X509Certificate2>] 
[-TenantId <String>] 
[-ContextScope <ContextScope>] 
[-Environment <String>]
[-ClientTimeout <Double>] 
[-NoWelcome] 
[<CommonParameters>]
```

### IdentityParameterSet
```powershell
Connect-Entra 
[[-ClientId] <String>] 
[-ContextScope <ContextScope>] 
[-Environment <String>]
[-ClientTimeout <Double>] 
[-Identity] 
[-NoWelcome] 
[<CommonParameters>]
```

### AppSecretCredentialParameterSet
```powershell
Connect-Entra 
[-ClientSecretCredential <PSCredential>] 
[-TenantId <String>] 
[-ContextScope <ContextScope>]
[-Environment <String>] 
[-ClientTimeout <Double>] 
[-NoWelcome] 
[<CommonParameters>]
```

### AccessTokenParameterSet
```powershell
Connect-Entra 
[-AccessToken] <SecureString> 
[-Environment <String>] 
[-ClientTimeout <Double>] 
[-NoWelcome]
[<CommonParameters>]
```

### EnvironmentVariableParameterSet
```powershell
Connect-Entra 
[-ContextScope <ContextScope>] 
[-Environment <String>] 
[-ClientTimeout <Double>]
[-EnvironmentVariable] 
[-NoWelcome] 
[<CommonParameters>]
```

## DESCRIPTION

The `Connect-Entra` cmdlet connects an authenticated account to use for Microsoft Entra ID cmdlet requests.

You can use this authenticated account only with Microsoft Entra ID cmdlets.

## EXAMPLES

### Example 1: Connect a session using a ApplicationId and CertificateThumbprint

```powershell
PS C:\> Connect-Entra -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -ApplicationId "8886ad7b-1795-4542-9808-c85859d97f23" -CertificateThumbprint F8813914053FBFB5D84F1EFA9EDB3205621C1126
```

```output
Welcome to Microsoft Graph!

Connected via apponly access using 8886ad7b-1795-4542-9808-c85859d97f23
Readme: https://aka.ms/graph/sdk/powershell
SDK Docs: https://aka.ms/graph/sdk/powershell/docs
API Docs: https://aka.ms/graph/docs

NOTE: You can use the -NoWelcome parameter to suppress this message.
```
This command Connect a session using a ApplicationId and CertificateThumbprint.

### Example 2: Delegated access using interactive authentication, where you provide the scopes that you require during your session

```powershell
PS C:\> Connect-Entra -Scopes "User.Read.All", "Group.ReadWrite.All"
```

```output
Welcome to Microsoft Graph!

Connected via apponly access using 8886ad7b-1795-4542-9808-c85859d97f23
Readme: https://aka.ms/graph/sdk/powershell
SDK Docs: https://aka.ms/graph/sdk/powershell/docs
API Docs: https://aka.ms/graph/docs

NOTE: You can use the -NoWelcome parameter to suppress this message.
```

This example shows how to authenticate to Entra with scopes.

### Example 3: Delegated access: Using your own access token

```powershell
PS C:\> $secureString = ConvertTo-SecureString -String $AccessToken -AsPlainText -Force
PS C:\> Connect-Entra -AccessToken $secureString
```

```output
Welcome to Microsoft Graph!

Connected via apponly access using 8886ad7b-1795-4542-9808-c85859d97f23
Readme: https://aka.ms/graph/sdk/powershell
SDK Docs: https://aka.ms/graph/sdk/powershell/docs
API Docs: https://aka.ms/graph/docs

NOTE: You can use the -NoWelcome parameter to suppress this message.
```
This example shows how to authenticate to graph using an access token.

### Example 4: Connecting to an environment as a different identity

```powershell
PS C:\> Connect-Entra -ContextScope "Process"
```

```output
Welcome to Microsoft Graph!

Connected via apponly access using 8886ad7b-1795-4542-9808-c85859d97f23
Readme: https://aka.ms/graph/sdk/powershell
SDK Docs: https://aka.ms/graph/sdk/powershell/docs
API Docs: https://aka.ms/graph/docs

NOTE: You can use the -NoWelcome parameter to suppress this message.
```

To connect as a different identity other than CurrentUser, specify the -ContextScope parameter with the value Process.

### Example 5: Connecting to an environment or cloud

```powershell
PS C:\> Get-MgEnvironment
```

```output
Name     AzureADEndpoint                   GraphEndpoint                           Type
----     ---------------                   -------------                           ----
China    https://login.chinacloudapi.cn    https://microsoftgraph.chinacloudapi.cn Built-in
Global   https://login.microsoftonline.com https://graph.microsoft.com             Built-in
USGov    https://login.microsoftonline.us  https://graph.microsoft.us              Built-in
USGovDoD https://login.microsoftonline.us  https://dod-graph.microsoft.us          Built-in
```

```powershell
Connect-Entra -Environment Global
```

When you use Connect-Entra, you can choose to target other environments. By default, Connect-Entra targets the global public cloud.

### Example 6: Sets the HTTP client timeout in seconds

```powershell
PS C:\> Connect-Entra -ClientTimeout 60
```

```output
Welcome to Microsoft Graph!

Connected via apponly access using 8886ad7b-1795-4542-9808-c85859d97f23
Readme: https://aka.ms/graph/sdk/powershell
SDK Docs: https://aka.ms/graph/sdk/powershell/docs
API Docs: https://aka.ms/graph/docs

NOTE: You can use the -NoWelcome parameter to suppress this message.
```

This example Sets the HTTP client timeout in seconds.

### Example 7: Hides the welcome message

```powershell
PS C:\> Connect-Entra -NoWelcome
```

This example Hides the welcome message.

### Example 8: Using device code flow

```powershell
PS C:\> Connect-Entra -UseDeviceAuthentication
```

```output
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code N3EXHFSVW to authenticate.
```

This example shows how to authenticate to Entra with device.

### Example 9: App-only access: Using client credential with a certificate - Certificate name

```powershell
PS C:\> Connect-Entra -ClientId "YOUR_APP_ID" -TenantId "YOUR_TENANT_ID" -CertificateName "YOUR_CERT_SUBJECT"
```
Follow this link (https://learn.microsoft.com/powershell/microsoftgraph/authentication-commands) for more information on how to load the certificate.

### Example 10: App-only access: Using client credential with a certificate - Certificate

```powershell
PS C:\> $Cert = Get-ChildItem Cert:\LocalMachine\My\$CertThumbprint
PS C:\> Connect-Entra -ClientId "YOUR_APP_ID" -TenantId "YOUR_TENANT_ID" -Certificate $Cert
```
Follow this link (https://learn.microsoft.com/powershell/microsoftgraph/authentication-commands) for more information on how to load the certificate.

### Example 11: Using client secret credentials

```powershell
PS C:\> $ClientSecretCredential = Get-Credential -Credential "Client_Id"
# Enter client_secret in the password prompt.
PS C:\> Connect-Entra -TenantId "Tenant_Id" -ClientSecretCredential $ClientSecretCredential
```

This authentication method is ideal for background interactions. It doesn't require a user to physically sign in.

### Example 12: Using managed identity: System-assigned managed identity

```powershell
PS C:\> Connect-Entra -Identity
```

Uses an automatically managed identity on a service instance. The identity is tied to the lifecycle of a service instance.

### Example 13: Using managed identity: User-assigned managed identity

```powershell
PS C:\> Connect-Entra -Identity -ClientId "User_Assigned_Managed_identity_Client_Id"
```

Uses a user created managed identity as a standalone Azure resource.

### Example 14: Allows for authentication using environment variables

```powershell
PS C:\> Connect-Entra -EnvironmentVariable
```

This Example allows for authentication using environment variables.

## PARAMETERS

### -CertificateThumbprint
Specifies the certificate thumbprint of a digital public key X.509 certificate of a user account that has permission to perform this action.

```yaml
Type: String
Parameter Sets: AppCertificateParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ClientId
Specifies the application ID of the service principal.

```yaml
Type: String
Parameter Sets: UserParameterSet, IdentityParameterSet
Aliases: AppId, ApplicationId

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
```yaml
Type: String
Parameter Sets: AppCertificateParameterSet
Aliases: AppId, ApplicationId

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -AccessToken
Specifies a Microsoft Graph access token.

```yaml
Type: SecureString
Parameter Sets: AccessTokenParameterSet
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Specifies the ID of a tenant.

If you don't specify this parameter, the account is authenticated with the home tenant.

You must specify the TenantId parameter to authenticate as a service principal or when using Microsoft account.

```yaml
Type: String
Parameter Sets: UserParameterSet, AppCertificateParameterSet, AppSecretCredentialParameterSet
Aliases: Audience, Tenant

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
Specifies a bearer token for Microsoft Graph service. Access tokens do time out and you have to handle their refresh.
```yaml
Type: SecureString
Parameter Sets: AccessTokenParameterSet
Aliases: 
Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientTimeout
Sets the HTTP client timeout in seconds.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContextScope
Determines the scope of authentication context. This ContextScope accepts `Process` for the current process, or `CurrentUser` for all sessions started by user.

```yaml
Type: ContextScope
Accepted values: Process, CurrentUser
Parameter Sets: UserParameterSet, AppCertificateParameterSet, IdentityParameterSet, AppSecretCredentialParameterSet, EnvironmentVariableParameterSet
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Environment
The name of the national cloud environment to connect to. By default global cloud is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: EnvironmentName, NationalCloud
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoWelcome
Hides the welcome message.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes
An array of delegated permissions to consent to.

```yaml
Type: String[]
Parameter Sets: UserParameterSet
Aliases: 
Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDeviceCode
Use device code authentication instead of a browser control.

```yaml
Type: SwitchParameter
Parameter Sets: UserParameterSet
Aliases: 	UseDeviceAuthentication, DeviceCode, DeviceAuth, Device
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Certificate
An X.509 certificate supplied during invocation.

```yaml
Type: X509Certificate2
Parameter Sets: AppCertificateParameterSet
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateSubjectName
The subject distinguished name of a certificate. The Certificate is retrieved from the current user's certificate store.

```yaml
Type: String
Parameter Sets: AppCertificateParameterSet
Aliases: CertificateSubject, CertificateName
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecretCredential
The PSCredential object provides the application ID and client secret for service principal credentials. For more information about the PSCredential object, type Get-Help Get-Credential.

```yaml
Type: PSCredential
Parameter Sets: AppSecretCredentialParameterSet
Aliases: SecretCredential, Credential
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnvironmentVariable
Allows for authentication using environment variables configured on the host machine. See https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/identity/Azure.Identity#environment-variables

```yaml
Type: SwitchParameter
Parameter Sets: EnvironmentVariableParameterSet
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Sign-in using a Managed Identity

```yaml
Type: SwitchParameter
Parameter Sets: IdentityParameterSet
Aliases: ManagedIdentity, ManagedServiceIdentity, MSI
Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
The ProgressAction parameter takes one of the ActionPreference enumeration values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend, or Break.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Disconnect-Entra](Disconnect-Entra.md)