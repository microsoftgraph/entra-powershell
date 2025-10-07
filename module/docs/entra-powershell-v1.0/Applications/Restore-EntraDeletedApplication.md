---
author: msewaweru
description: This article provides details on the Restore-EntraDeletedApplication command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Applications
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Restore-EntraDeletedApplication
schema: 2.0.0
title: Restore-EntraDeletedApplication
---

# Restore-EntraDeletedApplication

## SYNOPSIS

Restores a previously deleted application.

## SYNTAX

```powershell
Restore-EntraDeletedApplication
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 -ApplicationId <String>
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet restores a previously deleted application.

Restoring an application doesn't restore the associated service principal automatically. You must explicitly restore the deleted service principal.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- Application Administrator
- Cloud Application Administrator
- Hybrid Identity Administrator

## EXAMPLES

### Example 1: Restores a previously deleted application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$deletedApplication = Get-EntraDeletedApplication -SearchString 'My PowerShell Application'
Restore-EntraDeletedApplication -ApplicationId $deletedApplication.Id
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa
```

This example shows how an application is deleted, then the deleted application is retrieved using the `Get-EntraDeletedApplication` cmdlet, and subsequently the application is restored by specifying the application's Object ID in the `Restore-EntraDeletedApplication` cmdlet.

- `-ApplicationId` parameter specifies the ObjectId of the deleted application that is to be restored.

## PARAMETERS

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

### -ApplicationId

The ApplicationId (Object Id) of the deleted application that is to be restored.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Object

Required: True
Position: Named
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

[Remove-EntraDeletedApplication](Remove-EntraDeletedApplication.md)

[Get-EntraDeletedApplication](Get-EntraDeletedApplication.md)
