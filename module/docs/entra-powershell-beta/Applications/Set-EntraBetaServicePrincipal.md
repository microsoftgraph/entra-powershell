---
author: msewaweru
description: This article provides details on the Set-EntraBetaServicePrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/10/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaServicePrincipal
schema: 2.0.0
title: Set-EntraBetaServicePrincipal
---

# Set-EntraBetaServicePrincipal

## SYNOPSIS

Updates a service principal.

## SYNTAX

```powershell
Set-EntraBetaServicePrincipal
 -ServicePrincipalId <String>
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]>]
 [-Homepage <String>]
 [-AppId <String>]
 [-LogoutUrl <String>]
 [-ServicePrincipalType <String>]
 [-AlternativeNames <System.Collections.Generic.List`1[System.String]>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]>]
 [-PreferredSingleSignOnMode <String>]
 [-Tags <System.Collections.Generic.List`1[System.String]>]
 [-AccountEnabled <String>]
 [-ServicePrincipalNames <System.Collections.Generic.List`1[System.String]>]
 [-AppRoleAssignmentRequired <Boolean>]
 [-DisplayName <String>]
 [-ReplyUrls <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaServicePrincipal` cmdlet updates a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Disable the account of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -AccountEnabled $false
```

This example demonstrates how to update `AccountEnabled` of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-AccountEnabled` parameter specifies indicates whether the account is enabled.

### Example 2: Update Homepage of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$homePage = 'https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z'
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -Homepage $homePage
```

This example demonstrates how to update `AppId` and Homepage of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-AppId` parameter specifies the application ID.
- `-Homepage` parameter specifies the home page or landing page of the application.

### Example 3: Update AlternativeNames and DisplayName of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -AlternativeNames 'Helpdesk Application Global' -DisplayName 'NewName'
```

This example demonstrates how to update AlternativeNames and DisplayName of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

### Example 4: Update LogoutUrl and ReplyUrls of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$logoutUrl = 'https://securescore.office.com/SignOut'
$replyUrls = 'https://admin.contoso.com'
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -LogoutUrl $logoutUrl -ReplyUrls $replyUrls
```

This example demonstrates how to update LogoutUrl and ReplyUrls of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-LogoutUrl` parameter specifies the sign out URL.
- `-ReplyUrls` parameter specifies the URLs that user tokens are sent to for sign in with the associated application.

### Example 5: Update ServicePrincipalType and AppRoleAssignmentRequired of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -ServicePrincipalType 'Application' -AppRoleAssignmentRequired $True
```

This example demonstrates how to update `ServicePrincipalType` and `AppRoleAssignmentRequired` of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-ServicePrincipalType` parameter specifies the service principal type.
- `-AppRoleAssignmentRequired` parameter specifies indicates whether an application role assignment is required.

### Example 6: Update KeyCredentials of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
$creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes('Test')
$startdate = Get-Date -Year 2024 -Month 10 -Day 10
$creds.StartDate = $startdate
$creds.Type = 'Symmetric'
$creds.Usage = 'Sign'
$creds.Value = [System.Text.Encoding]::UTF8.GetBytes('A')
$creds.EndDate = Get-Date -Year 2025 -Month 12 -Day 20 
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.ObjectId -KeyCredentials $creds
```

This example demonstrates how to update KeyCredentials of a service principal in Microsoft Entra ID.

Use the `New-EntraBetaServicePrincipalPasswordCredential` and `Remove-EntraBetaServicePrincipalPasswordCredential` cmdlets to update the password or secret for a servicePrincipal.

### Example 7: Update PreferredSingleSignOnMode of a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Set-EntraBetaServicePrincipal -ServicePrincipalId $servicePrincipal.Id -PreferredSingleSignOnMode 'saml'
```

This example demonstrates how to update `PreferredSingleSignOnMode` of a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-PreferredSingleSignOnMode` parameter specifies the single sign-on mode configured for this application.

## PARAMETERS

### -AccountEnabled

Indicates whether the account is enabled.

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

### -AlternativeNames

The alternative names for this service principal.

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

### -AppId

Specifies the application ID.

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

### -AppRoleAssignmentRequired

Indicates whether an application role assignment is required.

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

### -Homepage

Specifies the home page or landing page of the application.

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

### -KeyCredentials

Specifies key credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogoutUrl

Specifies the sign out URL.

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

### -ServicePrincipalId

Species the ID of a service principal in Microsoft Entra ID.

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

### -PasswordCredentials

Specifies password credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreferredSingleSignOnMode

Specifies the single sign-on mode configured for this application. Microsoft Entra ID uses the preferred single sign-on mode to launch the application from Microsoft 365 or the My Apps portal. The supported values are password, saml, notSupported, and oidc.

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

### -ReplyUrls

The URLs that user tokens are sent to for sign in with the associated application, or the redirect Uniform Resource Identifiers that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.

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

### -ServicePrincipalNames

Specifies service principal names.

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

### -ServicePrincipalType

The service principal type.

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

Specifies an array of tags.

If you intend for this service principal to show up in the All Applications list in the admin portal, you need to set this value to {WindowsAzureActiveDirectoryIntegratedApp}.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[New-EntraBetaServicePrincipal](New-EntraBetaServicePrincipal.md)

[Remove-EntraBetaServicePrincipal](Remove-EntraBetaServicePrincipal.md)
