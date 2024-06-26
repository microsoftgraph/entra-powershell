---
title: New-EntraMSApplicationExtensionProperty
description: This article provides details on the New-EntraMSApplicationExtensionProperty command.

ms.service: entra
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSApplicationExtensionProperty

## SYNOPSIS

Creates an extension property on an application object.

## SYNTAX

```powershell
New-EntraMSApplicationExtensionProperty 
 -ObjectId <String> 
 [-DataType <String>] 
 [-TargetObjects <System.Collections.Generic.List`1[System.String]>] 
 [-Name <String>] 
 [<CommonParameters>]
```

## DESCRIPTION

Creates an extension property on an application object.

## EXAMPLES

### Example 1: Create an extension property

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
New-EntraMSApplicationExtensionProperty -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DataType 'String' -Name 'NewAttribute' -TargetObjects 'Application'
```

```Output
ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb extension_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb_NewAttribute {}
```

This command creates an application extension property of the String type for the specified object.

## PARAMETERS

### -DataType

Specifies the data type of the extension property.

Following values are supported.

- Binary - 256 bytes maximum
- Boolean
- DateTime - Must be specified in ISO 8601 format. Will be stored in UTC.
- Integer - 32-bit value.
- LargeInteger - 64-bit value.
- String - 256 characters maximum

This parameter is not nullable. For multivalued directory extensions, these limits apply per value in the collection.

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

### -Name

Specifies the data type of the extension property.

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

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object

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

### -TargetObjects

Specifies target objects.

All values must be in PascalCase. The following values are supported. Not nullable.

- User
- Group
- AdministrativeUnit
- Application
- Device
- Organization

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

### String

### System.Collections.Generic.List`1[System.String]

## OUTPUTS

### Microsoft.Open.MSGraph.Model.ExtensionProperty

## NOTES

## RELATED LINKS

[Get-EntraMSApplicationExtensionProperty](Get-EntraMSApplicationExtensionProperty.md)

[Remove-EntraMSApplicationExtensionProperty](Remove-EntraMSApplicationExtensionProperty.md)
