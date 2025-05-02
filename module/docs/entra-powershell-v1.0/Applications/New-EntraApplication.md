---
title: New-EntraApplication
description: This article provides details on the New-EntraApplication command.

ms.topic: reference
ms.date: 04/26/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Applications-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraApplication

schema: 2.0.0
---

# New-EntraApplication

## Synopsis

Creates a new application registration in Microsoft Entra ID.

## Syntax

### CreateApplication (Default)

```powershell
New-EntraApplication -DisplayName <String>
 [-SignInAudience <String>]
 [-IdentifierUris <List[String]>]
 [-IsDeviceOnlyAuthSupported <Boolean>]
 [-IsFallbackPublicClient <Boolean>]
 [-AppRoles <List[MicrosoftGraphAppRole]>]
 [-RequiredResourceAccess <MicrosoftGraphRequiredResourceAccess[]>]
 [-Api <MicrosoftGraphApiApplication>]
 [-PublicClient <MicrosoftGraphPublicClientApplication>]
 [-Web <MicrosoftGraphWebApplication>]
 [-InformationalUrl <MicrosoftGraphInformationalUrl>]
 [-ParentalControlSettings <MicrosoftGraphParentalControlSettings>]
 [-OptionalClaims <MicrosoftGraphOptionalClaims>]
 [-AddIns <Object[]>]
 [-KeyCredentials <Object[]>]
 [-PasswordCredentials <MicrosoftGraphPasswordCredential[]>]
 [-Tags <List[String]>]
 [-GroupMembershipClaims <String>]
 [-TokenEncryptionKeyId <String>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

### CreateWithAdditionalProperties

```powershell
New-EntraApplication [-DisplayName <String>] -AdditionalProperties <Hashtable>
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## Description

The `New-EntraApplication` cmdlet creates a new application registration in Microsoft Entra ID. Applications can be configured for different authentication scenarios, including single-tenant or multitenant, and can use various credential types.

## Examples

### Example 1: Create a basic application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraApplication -DisplayName 'Contoso HR App'
```

```Output
DisplayName               Id                                   AppId                                SignInAudience PublisherDomain
-----------               --                                   -----                                -------------- ---------------
Contoso HR Onboarding App dddd3333-ee44-5555-66ff-777777aaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg   contoso.com
```

This command creates a basic application registration with default settings.

### Example 2: Create a multitenant application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraApplication -DisplayName 'Contoso Partner API' -SignInAudience 'AzureADMultipleOrgs'
```

```Output
DisplayName               Id                                   AppId                                SignInAudience PublisherDomain
-----------               --                                   -----                                -------------- ---------------
Contoso Partner API App   dddd3333-ee44-5555-66ff-777777aaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg   contoso.com
```

This command creates an application that can be used by accounts from any Microsoft Entra ID tenant.

### Example 3: Create an application with an application password (client secret)

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$passwordCred = [Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential]@{
    DisplayName = 'AI automation Cred'
    StartDateTime = [DateTime]::UtcNow
    EndDateTime = [DateTime]::UtcNow.AddYears(1)
}

$app = New-EntraApplication -DisplayName 'Contoso Automation App' -PasswordCredentials @($passwordCred)
$app.PasswordCredentials.SecretText
```

This command creates an application with a password credential (client secret). The secret value is returned in the response.

### Example 4: Create an application with API permissions

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$msGraphAccess = @{
    ResourceAppId = "00000003-0000-0000-c000-000000000000"  # Microsoft Graph
    ResourceAccess = @(
        @{
            Id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"  # User.Read
            Type = "Scope"
        },
        @{
            Id = "df021288-bdef-4463-88db-98f22de89214"  # User.ReadWrite.All
            Type = "Role"
        }
    )
}

New-EntraApplication -DisplayName "User Management App" -RequiredResourceAccess @($msGraphAccess)
```

This command creates an application with specified Microsoft Graph API permissions.

### Example 5: Create an application with add-ins details

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$addIn = @{
    Id         = "00000002-0000-0ff1-ce00-000000000000"  # Outlook's service principal ID
    Type       = "messageReadCommandSurface"          # UI surface
    Properties = @(
        @{ Key = "extensionId"; Value = "Contoso.EmailInsights" },
        @{ Key = "sourceLocation"; Value = "https://contoso.com/addin/home.html" },
        @{ Key = "supportedLocales"; Value = "en-US" }
    )
}

New-EntraApplication -DisplayName "Contoso Email Insights" -AddIns $addIn
```

This command creates an application with add-ins details.

### Example 6: Create an application with app roles

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$appRoles = @(
    @{
        AllowedMemberTypes = @("User")
        DisplayName = "Readers"
        Description = "Can read content"
        Value = "Reader"
    },
    @{
        AllowedMemberTypes = @("User", "Application")
        DisplayName = "Administrators"
        Description = "Can manage all aspects"
        Value = "Admin"
    }
)

New-EntraApplication -DisplayName "Contoso Role-based App" -AppRoles $appRoles
```

This command creates an application with defined app roles.

### Example 7: Create a web application with identifier URIs

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraApplication -DisplayName 'Contoso App' -IdentifierUris 'https://myselfserve.contoso.com'
```

This command creates an application with identifier URIs.

### Example 8: Create an application using AdditionalProperties

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$props = @{
    displayName = "Advanced Configuration App"
    signInAudience = "AzureADMyOrg"
    api = @{
        oauth2PermissionScopes = @(
            @{
                id = [Guid]::NewGuid().ToString("D")
                adminConsentDescription = "Allow the app to access resources on user's behalf"
                adminConsentDisplayName = "Access resources"
                isEnabled = $true
                type = "Admin"
                value = "access"
            }
        )
    }
}

New-EntraApplication -AdditionalProperties $props
```

This command creates an application using the AdditionalProperties parameter for advanced configuration.

### Example 9: Create an application with tagging details

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraApplication -DisplayName "Contoso Tagged App" `
    -SignInAudience "AzureADMultipleOrgs" `
    -Tags @(
        "WindowsAzureActiveDirectoryIntegratedApp",
        "HideApp",
        "CertifiedApp"
    )
```

This command creates an application with tags.

### Example 10: Create an application with RequiredResourceAccess details

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
# Define the RequiredResourceAccess for Microsoft Graph API
$graphResourceAccess = @{
    ResourceAppId = '00000003-0000-0000-c000-000000000000'  # Microsoft Graph API AppID
    ResourceAccess = @(
        @{
            Id = 'e1fe6dd8-ba31-4d61-89e7-88639da4683d'  # GUID for 'User.Read' permission
            Type = 'Scope'  # Type of permission
        }
    )
}

# Define the RequiredResourceAccess for Azure Service Management API
$serviceManagementResourceAccess = @{
    ResourceAppId = '797f4846-ba00-4fd7-ba43-dac1f8f63013'  # Azure Service Management API ID
    ResourceAccess = @(
        @{
            Id = '41094075-9dad-400e-a0bd-54e686782033'  # GUID for 'user_impersonation' 
            Type = 'Scope'  # Type of permission
        }
    )
}

# Combine both resource accesses into an array
$RequiredResourceAccess = @($graphResourceAccess, $serviceManagementResourceAccess)

# Create a new application with the required resource access
New-EntraApplication -DisplayName 'Contoso Service App' -RequiredResourceAccess $RequiredResourceAccess
```

This command creates an application with resource access details.

### Example 11: Create a web application with redirect URIs

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$web = @{
    redirectUris = @("https://contoso.com/auth", "https://contoso.com/auth/callback")
    implicitGrantSettings = @{
        enableAccessTokenIssuance = $true
        enableIdTokenIssuance = $true
    }
    logoutUrl = "https://contoso.com/logout"
}

New-EntraApplication -DisplayName "Contoso Web App" -Web $web
```

This command creates a web application with redirect URIs and implicit grant settings.

### Example 12: Create an application with a certificate credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("C:\Certificates\MyCertificate.cer")
$thumbprint = $cert.Thumbprint
$base64Cert = [Convert]::ToBase64String($cert.RawData)

$keyCred = @{
    CustomKeyIdentifier = $thumbprint
    Type = "AsymmetricX509Cert"
    Usage = "Verify"
    Key = $base64Cert
    DisplayName = "App Certificate"
    StartDateTime = [DateTime]::UtcNow
    EndDateTime = [DateTime]::UtcNow.AddYears(1)
}

New-EntraApplication -DisplayName "Contoso Certificate App" -KeyCredentials @($keyCred)
```

This command creates an application with a certificate credential.

## Parameters

### -DisplayName

The display name of the application in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: CreateApplication
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: CreateWithAdditionalProperties
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SignInAudience

Defines which accounts are supported for this application. Valid values: `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount`, `PersonalMicrosoftAccount`.

```yaml
Type: String
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentifierUris

URIs that uniquely identify the application within Azure AD.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Custom tags that can be used to categorize and identify the application.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupMembershipClaims

Configures the groups claim issued in a user or OAuth 2.0 access token. Valid values: `None`, `SecurityGroup`, `All`.

```yaml
Type: String
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TokenEncryptionKeyId

Specifies the keyId of a public key from the keyCredentials collection for token encryption.

```yaml
Type: String
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDeviceOnlyAuthSupported

Specifies whether this application supports device authentication without a user.

```yaml
Type: System.Nullable`1[System.Boolean]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsFallbackPublicClient

Specifies whether the application is a public client. If not set, the default behavior is `false`.

```yaml
Type: System.Nullable`1[System.Boolean]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppRoles

The collection of application roles defined for the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppRole]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredResourceAccess

The API permissions required by the application to other resources such as Microsoft Graph.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequiredResourceAccess[]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Api

The API settings for the application, including OAuth2 permission scopes and app roles.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphApiApplication
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublicClient

Settings for a public client application (mobile or desktop).

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphPublicClientApplication
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Web

Settings for a web application, including redirect URIs and logout URL.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphWebApplication
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationalUrl

URLs with more information about the application (marketing, terms of service, privacy, etc.).

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphInformationalUrl
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentalControlSettings

Specifies parental control settings for an application.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphParentalControlSettings
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptionalClaims

The optional claims configuration that is included in access and ID tokens.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphOptionalClaims
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddIns

Defines custom behavior extensions for the application.

```yaml
Type: System.Object[]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials

The collection of certificate credentials associated with the application. Each credential should contain:
- CustomKeyIdentifier: (Optional) Certificate thumbprint
- DisplayName: (Optional) Friendly name for the credential
- EndDateTime: Expiration date and time in UTC
- Key: Base64-encoded certificate data
- StartDateTime: Start date and time in UTC
- Type: Type of the credential, typically "AsymmetricX509Cert"
- Usage: Purpose of the credential, typically "Verify"

```yaml
Type: System.Object[]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordCredentials

The collection of password credentials associated with the application.

```yaml
Type: Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential[]
Parameter Sets: CreateApplication
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdditionalProperties

Custom properties to send directly to the Microsoft Graph API.

```yaml
Type: Hashtable
Parameter Sets: CreateWithAdditionalProperties
Aliases: Body, Properties, BodyParameter

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

This cmdlet doesn't accept pipeline input.

## Outputs

### PSCustomObject

Returns a custom object representing the created Microsoft Entra application.

## Notes

- This cmdlet requires the 'Application.ReadWrite.All' permission scope.
- When using certificate credentials, ensure proper certificate management practices:
  * Use strong key sizes (RSA 2048-bit or higher)
  * Store private keys securely
  * Implement certificate rotation before expiration
- Password credentials (client secrets) should be used only when certificates can't be used.
- For security best practices, consider:
  * Using the least privilege principle when assigning API permissions
  * Limiting application roles to only what's necessary
  * Using conditional access policies for sensitive applications
  * Implementing proper credential rotation processes

## Related Links

[Get-EntraApplication](Get-EntraApplication.md)

[Remove-EntraApplication](Remove-EntraApplication.md)

[Update-EntraApplication](Update-EntraApplication.md)

[Microsoft Entra application management documentation](https://learn.microsoft.com/entra/identity-platform/quickstart-register-app)
