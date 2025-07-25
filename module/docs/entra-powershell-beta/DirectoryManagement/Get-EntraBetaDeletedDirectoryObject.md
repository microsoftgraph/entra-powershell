---
description: This article provides details on the Get-EntraBetaDeletedDirectoryObject command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDeletedDirectoryObject
schema: 2.0.0
title: Get-EntraBetaDeletedDirectoryObject
---

# Get-EntraBetaDeletedDirectoryObject

## SYNOPSIS

Retrieves a soft deleted directory object from the directory.

## SYNTAX

```powershell
Get-EntraBetaDeletedDirectoryObject
 -DirectoryObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDeletedDirectoryObject` cmdlet retrieves a soft deleted directory object from the directory.

Note that soft delete for groups is currently only implemented for Unified Groups (also known as
Office 365 Groups).

## EXAMPLES

### Example 1: Retrieve a deleted directory object with more details

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All', 'Application.Read.All','Group.Read.All','User.Read.All'
Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' | Format-Table -Property Id, displayName, '@odata.type', DeletedDateTime, DeletionAgeInDays -AutoSize
```

```Output
Id                                   displayName           @odata.type                  DeletedDateTime       DeletionAgeInDays
--                                   -----------           -----------                  ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Entra PowerShell App #microsoft.graph.application 2/12/2025 11:07:56 AM                10
```

This example shows how to retrieve the deleted directory object details from the directory.

**Note**: You can use the following commands to retrieve specific deleted objects:

- `Get-EntraBetaDeletedUser` - to retrieve deleted users.
- `Get-EntraBetaDeletedAdministrativeUnit` - to retrieve deleted administrative units.
- `Get-EntraBetaDeletedApplication` - to retrieve deleted applications.
- `Get-EntraBetaDeletedDevice` - to retrieve deleted devices.
- `Get-EntraBetaDeletedGroup` - to retrieve deleted groups.
- `Get-EntraBetaDeletedServicePrincipal` - to retrieve deleted service principals.

## PARAMETERS

### -DirectoryObjectId

The Id of the directory object to retrieve.

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Get-EntraBetaDeletedAdministrativeUnit](Get-EntraBetaDeletedAdministrativeUnit.md)

[Get-EntraBetaDeletedDevice](Get-EntraBetaDeletedDevice.md)
