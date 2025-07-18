---
author: msewaweru
description: This article provApplicationTemplateIdes details on the New-EntraApplicationFromApplicationTemplate command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/10/2025
ms.reviewer: stevemutungi
ms.service: entra
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraApplicationFromApplicationTemplate
schema: 2.0.0
title: New-EntraApplicationFromApplicationTemplate
---

# New-EntraApplicationFromApplicationTemplate

## SYNOPSIS

Add an instance of an application from the Microsoft Entra gallery to your directory.

## SYNTAX

```powershell
New-EntraApplicationFromApplicationTemplate
 -ApplicationTemplateId <String>
 -DisplayName <ApplicationTemplateDisplayName>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraApplicationFromApplicationTemplate` cmdlet adds an instance of an application from the Microsoft Entra gallery to your directory.

For non-gallery apps, use these application template IDs to configure SSO modes like SAML or password-based SSO:

- Global service: `8adf8e6e-67b2-4cf2-a259-e3dc5476c621`
- US government: `4602d0b4-76bb-404b-bca9-2652e1a39c6d`
- China (21Vianet): `5a532e38-1581-4918-9658-008dc27c1d68`

## EXAMPLES

### Example 1: Creates an application from application template

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$applicationTemplate = Get-EntraApplicationTemplate -Filter "DisplayName eq 'SAP Fieldglass'"
New-EntraApplicationFromApplicationTemplate -ApplicationTemplateId $applicationTemplate.Id -DisplayName 'Contoso SAP App'
```

```Output
@odata.context                                                                         servicePrincipal
--------------                                                                         ----------------
https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.applicationServicePrincipal @{oauth2PermissionScopes=System.Object[]; servicePrincipalType=Application; displ...}
```

This command instantiates a new application based on application template referenced by the ID.

- `-ApplicationTemplateId` specifies Application TemplateId.
- `-DisplayName` specifies application template display name.

## PARAMETERS

### -ApplicationTemplateId

The ID parameter specifies Application TemplateId.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DisplayName

Application template display name.

```yaml
Type: System.ApplicationTemplateDisplayName
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.ApplicationTemplateCopy

## NOTES

Quickstart: [Add an enterprise application](https://learn.microsoft.com/entra/identity/enterprise-apps/add-application-portal).

## RELATED LINKS

[Get-EntraApplicationTemplate](Get-EntraApplicationTemplate.md)
