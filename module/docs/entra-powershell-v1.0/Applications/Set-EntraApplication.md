---
author: msewaweru
description: This article provides details on the Set-EntraApplication command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraApplication
schema: 2.0.0
title: Set-EntraApplication
---

# Set-EntraApplication

## SYNOPSIS

Updates the properties of an application object.

## SYNTAX

```powershell
Set-EntraApplication
 -ApplicationId <String>
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]>]
 [-TokenEncryptionKeyId <String>]
 [-SignInAudience <String>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-ParentalControlSettings <ParentalControlSettings>]
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 [-AppRoles <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]>]
 [-PublicClient <PublicClientApplication>]
 [-InformationalUrl <InformationalUrl>]
 [-Tags <System.Collections.Generic.List`1[System.String]>]
 [-Api <ApiApplication>]
 [-OptionalClaims <OptionalClaims>]
 [-GroupMembershipClaims <String>]
 [-Web <WebApplication>]
 [-DisplayName <String>]
 [-IsFallbackPublicClient <Boolean>]
 [-IsDeviceOnlyAuthSupported <Boolean>]
 [-RequiredResourceAccess <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]>]
 [<CommonParameters>]
```

## DESCRIPTION

Updates the properties of an application object.

## EXAMPLES

### Example 1: Update an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$params = @{
    ApplicationId = $application.Id
    DisplayName = 'Contoso Entra PowerShell App Production'
    IdentifierUris = 'https://contoso.com'
    GroupMembershipClaims = 'SecurityGroup'
    IsDeviceOnlyAuthSupported = $False
    Tags = 'mytag'
}
Set-EntraApplication @params
```

This command updates an application in Microsoft Entra ID.

### Example 2: Update an application using IdentifierUris parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraApplication -ApplicationId $application.Id -IdentifierUris 'https://mynewapp.contoso.com'
```

This command updates an application in Microsoft Entra ID.

### Example 3: Update an application using GroupMembershipClaims parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraApplication -ApplicationId $application.Id -GroupMembershipClaims 'SecurityGroup'
```

This command updates an application in Microsoft Entra ID.

### Example 4: Update an application using IsDeviceOnlyAuthSupported parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraApplication -ApplicationId $application.Id -IsDeviceOnlyAuthSupported $False
```

This command updates an application in Microsoft Entra ID.

### Example 5: Update an application using Tags parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraApplication -ApplicationId $application.Id -Tags 'mytag'
```

This command updates an application in Microsoft Entra ID.

### Example 6: Add a role (AppRole) to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -SearchString 'Contoso Helpdesk Application'
$appRole = New-Object Microsoft.Open.MSGraph.Model.AppRole
$appRole.AllowedMemberTypes = @("User", "Application")
$appRole.Description = "General role"
$appRole.DisplayName = "General"
$appRole.Id = [guid]::NewGuid()
$appRole.IsEnabled = $true
$appRole.Value = "General"
$tags = "WindowsAzureActiveDirectoryIntegratedApp"
Set-EntraApplication -ApplicationId $application.Id -AppRoles $appRole -Tags $tags
```

This command adds an app role to an application. To retain existing app roles, include them in your request. Any roles not included will be replaced. This object syncs with the corresponding service principal property in the tenant.

The `AllowedMemberTypes` can take the values:

- `@("User", "Application")` - for users, groups and applications.
- `"User"` - for users and groups.
- `"Application"` - for applications.

## PARAMETERS

### -Api

Specifies settings for an application that implements a web API.

```yaml
Type: ApiApplication
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppRoles

The collection of application roles that an application might declare.

These roles can be assigned to users, groups, or service principals.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupMembershipClaims

Configures the groups claim issued in a user or OAuth 2.0 access token that the application expects.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentifierUris

Specifies identifier Uniform Resource Identifiers (URIs).

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationalUrl

Basic profile information of the application such as app's marketing, support, terms of service and privacy statement URLs.

The terms of service and privacy statement are surfaced to users through the user consent experience.

```yaml
Type: InformationalUrl
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDeviceOnlyAuthSupported

Specifies if the application supports authentication using a device token.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsFallbackPublicClient

Specifies the fallback application type as public client, such as an installed application running on a mobile device.

The default value is `false` that means the fallback application type is confidential client such as web app.

There are certain scenarios where Microsoft Entra ID can't determine the client application type (for example, ROPC flow where it's configured without specifying a redirect URI).

In those cases Microsoft Entra ID interprets the application type based on the value of this property.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials

Specifies key credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OptionalClaims

Application developers can configure optional claims in their Microsoft Entra ID apps to specify which claims they want in tokens sent to their application by the Microsoft security token service.

```yaml
Type: OptionalClaims
Parameter Sets: (All)
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
Type: ParentalControlSettings
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordCredentials

Specifies password credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublicClient

Specifies whether this application is a public client (such as an installed application running on a mobile device). Default is `false`.

```yaml
Type: PublicClientApplication
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredResourceAccess

Specifies resources that this application requires access to and the set of OAuth permission scopes and application roles that it needs under each of those resources.

This pre-configuration of required resource access drives the consent experience.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SignInAudience

Specifies what Microsoft accounts are supported for the current application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Custom strings that can be used to categorize and identify the application.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TokenEncryptionKeyId

Specifies the keyId of a public key from the keyCredentials collection.

When configured, Microsoft Entra ID encrypts all the tokens it emits by using the key this property points to.

The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Web

Specifies settings for a web application.

```yaml
Type: WebApplication
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Boolean

### Microsoft.Open.MSGraph.Model.ApiApplication

### Microsoft.Open.MSGraph.Model.InformationalUrl

### Microsoft.Open.MSGraph.Model.OptionalClaims

### Microsoft.Open.MSGraph.Model.ParentalControlSettings

### Microsoft.Open.MSGraph.Model.PublicClientApplication

### Microsoft.Open.MSGraph.Model.WebApplication

### String

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]

### System.Collections.Generic.List`1[System.String]

### System.Nullable`1[System.Boolean]

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplication](Get-EntraApplication.md)

[New-EntraApplication](New-EntraApplication.md)

[Remove-EntraApplication](Remove-EntraApplication.md)
