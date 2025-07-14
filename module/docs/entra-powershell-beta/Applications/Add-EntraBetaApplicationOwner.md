---
description: This article provides details on the Add-EntraBetaApplicationOwner command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaApplicationOwner
schema: 2.0.0
title: Add-EntraBetaApplicationOwner
---

# Add-EntraBetaApplicationOwner

## SYNOPSIS

Adds an owner to an application.

## SYNTAX

### ByApplicationIdAndOwnerId

```powershell
Add-EntraBetaApplicationOwner
 -ApplicationId <String>
 -OwnerId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaApplicationOwner` adds an owner to a Microsoft Entra ID application. Only individual users are supported.

## EXAMPLES

### Example 1: Add a user as an owner to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
Add-EntraBetaApplicationOwner -ApplicationId $application.Id -OwnerId $user.Id
```

This example demonstrates how to add an owner to an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the ID of an application.
- `-OwnerId` parameter specifies the ID of a user.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationOwner](Get-EntraBetaApplicationOwner.md)

[Remove-EntraBetaApplicationOwner](Remove-EntraBetaApplicationOwner.md)
