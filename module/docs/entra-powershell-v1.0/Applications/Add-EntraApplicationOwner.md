---
description: This article provides details on the Add-EntraApplicationOwner command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraApplicationOwner
schema: 2.0.0
title: Add-EntraApplicationOwner
---

# Add-EntraApplicationOwner

## Synopsis

Adds an owner to an application.

## Syntax 

### ByApplicationIdAndOwnerId

```powershell
Add-EntraApplicationOwner
 -ApplicationId <String>
 -OwnerId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraApplicationOwner` adds an owner to a Microsoft Entra ID application. Only individual users are supported.

## Examples

### Example 1: Add a user as an owner to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Helpdesk Application'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraApplicationOwner -ApplicationId $application.Id -OwnerId $user.Id
```

This example demonstrates how to add an owner to an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the ID of an application.
- `-OwnerId` parameter specifies the ID of a user.

## Parameters

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

### -OwnerId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

## Notes

## Related links

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)
