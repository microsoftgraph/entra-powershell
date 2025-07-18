---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDeletedApplication command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDeletedApplication
schema: 2.0.0
title: Remove-EntraBetaDeletedApplication
---

# Remove-EntraBetaDeletedApplication

## SYNOPSIS

Permanently delete a recently deleted application object from deleted items.

## SYNTAX

```powershell
Remove-EntraBetaDeletedApplication
 [-ApplicationId] <String>
 [<CommonParameters>]
```

## DESCRIPTION

Permanently delete a recently deleted application object from deleted items. After an item is permanently deleted, it can't be restored.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- To permanently delete deleted applications or service principals: Application Administrator, Cloud Application Administrator, or Hybrid Identity Administrator.

## EXAMPLES

### Example 1: Remove deleted application object

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$deletedApplication = Get-EntraBetaDeletedApplication -SearchString 'My PowerShell Application' 
Remove-EntraBetaDeletedApplication -ApplicationId $deletedApplication.Id
```

This command removes recently deleted application. You can use the command  `Get-EntraBetaDeletedApplication` to get deleted application Id.

- `-ApplicationId` parameter specifies the Id of a deleted application.

### Example 2: Remove deleted application using pipelining

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Get-EntraBetaDeletedApplication -Filter "DisplayName eq 'My PowerShell Application'" | Remove-EntraBetaDeletedApplication
```

This command removes recently deleted application using pipelining.

## PARAMETERS

### -ApplicationId

The unique identifier of deleted application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Restore-EntraBetaDeletedApplication](Restore-EntraBetaDeletedApplication.md)

[Get-EntraBetaDeletedApplication](Get-EntraBetaDeletedApplication.md)
