---
description: This article provides details on the Get-EntraDeletedDirectoryObject command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedDirectoryObject
schema: 2.0.0
title: Get-EntraDeletedDirectoryObject
---

# Get-EntraDeletedDirectoryObject

## SYNOPSIS

Retrieves a soft deleted directory object from the directory.

## SYNTAX

```powershell
Get-EntraDeletedDirectoryObject
 -DirectoryObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDeletedDirectoryObject` cmdlet retrieves a soft deleted directory object from the directory.
Note that soft delete for groups is currently only implemented for Unified Groups (also known as
Office 365 Groups).

## EXAMPLES

### Example 1: Retrieve a deleted directory object with more details

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All', 'Application.Read.All','Group.Read.All','User.Read.All'
Get-EntraDeletedDirectoryObject -DirectoryObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' | Format-Table -Property Id, displayName, '@odata.type', DeletedDateTime, DeletionAgeInDays -AutoSize
```

```Output
Id                                   displayName           @odata.type                  DeletedDateTime       DeletionAgeInDays
--                                   -----------           -----------                  ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Entra PowerShell App #microsoft.graph.application 2/12/2025 11:07:56 AM                10
```

This example shows how to retrieve the deleted directory object details from the directory.

**Note**: You can use the following commands to retrieve specific deleted objects:

- `Get-EntraDeletedUser` - to retrieve deleted users.
- `Get-EntraDeletedAdministrativeUnit` - to retrieve deleted administrative units.
- `Get-EntraDeletedApplication` - to retrieve deleted applications.
- `Get-EntraDeletedDevice` - to retrieve deleted devices.
- `Get-EntraDeletedGroup` - to retrieve deleted groups.
- `Get-EntraDeletedServicePrincipal` - to retrieve deleted service principals.

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

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraDeletedAdministrativeUnit](Get-EntraDeletedAdministrativeUnit.md)

[Get-EntraDeletedDevice](Get-EntraDeletedDevice.md)
