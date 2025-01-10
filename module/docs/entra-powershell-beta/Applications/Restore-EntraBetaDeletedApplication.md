---
title:  Restore-EntraBetaDeletedApplication
description: This article provides details on the  Restore-EntraBetaDeletedApplication Command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Restore-EntraBetaDeletedApplication

schema: 2.0.0
---

# Restore-EntraBetaDeletedApplication

## Synopsis

Restores a previously deleted application.

## Syntax

```powershell
Restore-EntraBetaDeletedApplication
 -ObjectId <String>
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

This cmdlet restores a previously deleted application.

Restoring an application doesn't restore the associated service principal automatically. You must explicitly restore the deleted service principal.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- Application Administrator
- Cloud Application Administrator
- Hybrid Identity Administrator

## Examples

### Example 1: Restores a previously deleted application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$deletedApplication = Get-EntraBetaDeletedApplication -SearchString 'My PowerShell Application'
Restore-EntraBetaDeletedApplication -ObjectId $deletedApplication.Id
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa
```

This example shows how an application is deleted, then the deleted application is retrieved using the `Get-EntraBetaDeletedApplication` cmdlet, and subsequently the application is restored by specifying the application's Object ID in the `Restore-EntraBetaDeletedApplication` cmdlet.

- `-ObjectId` parameter specifies the ObjectId of the deleted application that is to be restored.

## Parameters

### -IdentifierUris

The IdentifierUris of the application that is to be restored.

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

### -ObjectId

The ObjectId of the deleted application that is to be restored.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[Remove-EntraBetaDeletedApplication](Remove-EntraBetaDeletedApplication.md)

[Get-EntraBetaDeletedApplication](Get-EntraBetaDeletedApplication.md)
