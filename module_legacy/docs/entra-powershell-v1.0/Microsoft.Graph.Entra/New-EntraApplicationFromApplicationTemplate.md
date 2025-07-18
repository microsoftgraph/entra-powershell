---
title: New-EntraApplicationFromApplicationTemplate
description: This article provides details on the New-EntraApplicationFromApplicationTemplate command.


ms.service: entra
ms.topic: reference
ms.date: 07/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraApplicationFromApplicationTemplate
schema: 2.0.0
---

# New-EntraApplicationFromApplicationTemplate

## Synopsis

Add an instance of an application from the Microsoft Entra application gallery into your directory.

## Syntax

```powershell
New-EntraApplicationFromApplicationTemplate
 -Id <String>
 -DisplayName <ApplicationTemplateDisplayName>
 [<CommonParameters>]
```

## Description

The `New-EntraApplicationFromApplicationTemplate` cmdlet adds an instance of an application from the Microsoft Entra application gallery into your directory.

The application template with ID `8adf8e6e-67b2-4cf2-a259-e3dc5476c621` can be used to add a non-gallery app that you can configure different single-sign on (SSO) modes like SAML SSO and password-based SSO.

## Examples

### Example 1: Creates an application from application template

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    DisplayName = 'ApplicationTemplate'
}
New-EntraApplicationFromApplicationTemplate @params
```

```Output
@odata.context                                                                         servicePrincipal
--------------                                                                         ----------------
https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.applicationServicePrincipal @{oauth2PermissionScopes=System.Object[]; servicePrincipalType=Application; displ...}
```

This command instantiates a new application based on application template referenced by the ID.

- `-Id` specifies Application TemplateId.
- `-DisplayName` specifies application template display name.

## Parameters

### -Id

The Id parameter specifies Application TemplateId.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

## Inputs

## Outputs

### Microsoft.Online.Administration.ApplicationTemplateCopy

## Notes

## Related Links
