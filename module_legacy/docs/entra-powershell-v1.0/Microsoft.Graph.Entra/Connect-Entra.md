---
title: Connect-Entra
description: This article provides details on the Connect-Entra Command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi254
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Connect-Entra

schema: 2.0.0
---

# Connect-Entra

## Synopsis

Connect to Microsoft Entra ID with an authenticated account.

## Syntax

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

## Description

The `Connect-Entra` cmdlet connects to Microsoft Entra ID with an authenticated account.

Several authentication scenarios are supported based on your use case, such as delegated (interactive) and app-only (non-interactive).

`Connect-Entra` is an alias for `Connect-MgGraph`.

## Examples

### Example 1: Delegated access: Connect a PowerShell session to a tenant

```powershell
Connect-Entra
```

This example shows how to connect your current PowerShell session to a Microsoft Entra ID tenant using credentials.

### Example 2: Delegated access: Connect a PowerShell session to a tenant with required scopes

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Group.ReadWrite.All'
```

```Output
Welcome to Microsoft Graph!

```

This example shows how to authenticate to Microsoft Entra ID with scopes.

### Example 3: Delegated access: Using an access token

```powershell
$secureString = ConvertTo-SecureString -String $AccessToken -AsPlainText -Force
Connect-Entra -AccessToken $secureString
```

```Output
Welcome to Microsoft Graph!
```

This example shows how to interactively authenticate to Microsoft Entra ID using an access token.

For more information on how to get or create access token, see [Request an access token](https://learn.microsoft.com/graph/auth-v2-user#3-request-an-access-token).

### Example 4: Delegated access: Using device code flow

```powershell
Connect-Entra -UseDeviceCode
```

```Output
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code A1B2CDEFGH to authenticate.
```

This example shows how to interactively authenticate to Microsoft Entra ID using device code flow.

For more information, see [Device Code flow](https://learn.microsoft.com/entra/identity-platform/v2-oauth2-device-code).

### Example 5: App-only access: Using client credential with a Certificate thumbprint

```powershell
$connectParams = @{
    TenantId = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
    ApplicationId = '00001111-aaaa-2222-bbbb-3333cccc4444'
    CertificateThumbprint = 'AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00'
}

Connect-Entra @connectParams
```

```Output
Welcome to Microsoft Graph!
```

This example shows how to authenticate using an ApplicationId and CertificateThumbprint.

For more information on how to get or create CertificateThumbprint, see [Authenticate with app-only access](https://learn.microsoft.com/powershell/entra-powershell/app-only-access-auth).

### Example 6: App-only access: Using client credential with a certificate name

```powershell
$params = @{
    ClientId = '00001111-aaaa-2222-bbbb-3333cccc4444'
    TenantId = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
    CertificateName = 'YOUR_CERT_SUBJECT'
}

Connect-Entra @params
```

```powershell
 $Cert = Get-ChildItem Cert:\LocalMachine\My\$CertThumbprint
 Connect-Entra -ClientId '<App-Id>' -TenantId '<Tenant-Id>' -Certificate $Cert
```

You can find the certificate subject by running the above command.

### Example 7: App-only access: Using client credential with a certificate

```powershell
$Cert = Get-ChildItem Cert:\LocalMachine\My\$CertThumbprint
$params = @{
    ClientId = '00001111-aaaa-2222-bbbb-3333cccc4444'
    TenantId = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
    Certificate = $Cert
}

Connect-Entra @params
```

### Example 8: App-only access: Using client secret credentials

```powershell
$ClientSecretCredential = Get-Credential -Credential '00001111-aaaa-2222-bbbb-3333cccc4444'
# Enter client_secret in the password prompt.
Connect-Entra -TenantId 'aaaabbbb-0000-cccc-1111-dddd2222eeee' -ClientSecretCredential $ClientSecretCredential
```

This authentication method is ideal for background interactions.

For more information on how to get credential, see [Get-Credential](https://learn.microsoft.com/powershell/module/microsoft.powershell.security/get-credential) command.

### Example 9: App-only access: Using managed identity: System-assigned managed identity

```powershell
Connect-Entra -Identity
```

Uses an automatically managed identity on a service instance. The identity is tied to the lifecycle of a service instance.

### Example 10: App-only access: Using managed identity: User-assigned managed identity

```powershell
Connect-Entra -Identity -ClientId 'User_Assigned_Managed_identity_Client_Id'
```

Uses a user created managed identity as a standalone Azure resource.

### Example 11: Connecting to an environment as a different identity

```powershell
Connect-Entra -ContextScope 'Process'
```

```Output
Welcome to Microsoft Graph!
```

To connect as a different identity other than CurrentUser, specify the ContextScope parameter with the value Process.

For more information on how to get the current context, see [Get-EntraContext](https://learn.microsoft.com/powershell/module/microsoft.graph.entra/get-entracontext) command.

### Example 12: Connecting to an environment or cloud

```powershell
Get-EntraEnvironment
```

```Output
Name     AzureADEndpoint                   GraphEndpoint                           Type
----     ---------------                   -------------                           ----
China    https://login.chinacloudapi.cn    https://microsoftgraph.chinacloudapi.cn Built-in
Global   https://login.microsoftonline.com https://graph.microsoft.com             Built-in
USGov    https://login.microsoftonline.us  https://graph.microsoft.us              Built-in
USGovDoD https://login.microsoftonline.us  https://dod-graph.microsoft.us          Built-in
```

```powershell
Connect-Entra -Environment 'Global'
```

When you use Connect-Entra, you can choose to target other environments. By default, Connect-Entra targets the global public cloud.

### Example 13: Sets the HTTP client timeout in seconds

```powershell
 Connect-Entra -ClientTimeout 60
```

```Output
Welcome to Microsoft Graph!
```

This example Sets the HTTP client timeout in seconds.

### Example 14: Hides the welcome message

```powershell
Connect-Entra -NoWelcome
```

This example hides the welcome message.

### Example 15: Allows for authentication using environment variables

```powershell
Connect-Entra -EnvironmentVariable
```

This example allows for authentication using environment variables.

## Parameters

### -CertificateThumbprint

Specifies the certificate thumbprint of a digital public key X.509 certificate of a user account that has permission to perform this action.

```yaml
Type:  System.String
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
Type:  System.String
Parameter Sets: UserParameterSet, IdentityParameterSet
Aliases: AppId, ApplicationId

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type:  System.String
Parameter Sets: AppCertificateParameterSet
Aliases: AppId, ApplicationId

Required: True
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
Type:  System.String
Parameter Sets: UserParameterSet, AppCertificateParameterSet, AppSecretCredentialParameterSet
Aliases: Audience, Tenant

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken

Specifies a bearer token for Microsoft Entra service. Access tokens do time out and you have to handle their refresh.

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
Type: System.Double
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
Type:  System.String
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
Type: System.Management.Automation.SwitchParameter
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
Type:  System.String[]
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: UserParameterSet
Aliases: UseDeviceAuthentication, DeviceCode, DeviceAuth, Device
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

The subject distinguished name of a certificate. The certificate is retrieved from the current user's certificate store.

```yaml
Type: System.String
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

Allows for authentication using environment variables configured on the host machine. See <https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/identity/Azure.Identity#environment-variables>

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: EnvironmentVariableParameterSet
Aliases: 
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity

Sign-in using a managed identity

```yaml
Type: System.Management.Automation.SwitchParameter
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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Disconnect-Entra](Disconnect-Entra.md)