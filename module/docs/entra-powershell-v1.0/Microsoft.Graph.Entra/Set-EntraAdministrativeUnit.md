---
title: Set-EntraAdministrativeUnit.
description: This article provides details on the Set-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 06/19/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraAdministrativeUnit

schema: 2.0.0
---

# Set-EntraAdministrativeUnit

## Synopsis

Updates an administrative unit.

## Syntax

```powershell
Set-EntraAdministrativeUnit 
 -ObjectId <String> 
 [-Description <String>] 
 [-DisplayName <String>] 
 [<CommonParameters>]
```

## Description

The `Set-EntraAdministrativeUnit` cmdlet updates an administrative unit in Microsoft Entra ID. Specify `ObjectId` parameter for updates an administrative unit.

## Examples

### Example 1: Update Description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Description = 'Updated AU Description'
}
Set-EntraAdministrativeUnit @params
```

This Command update Description of specific administrative unit.

- `-ObjectId` - Specifies the ID of an administrative unit, which you want to update. In this example, `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` represents the ID of the administrative unit.

- `-Description` - Specifies a description, which you want to update.

### Example 2: Update DisplayName

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    DisplayName = 'UpdatedAU'
}
Set-EntraAdministrativeUnit @params
```

This Command update DisplayName specific administrative unit.

- `-ObjectId` - Specifies the ID of an administrative unit, which you want to update. In this example, `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` represents the ID of the administrative unit.

- `-DisplayName` - Specifies a display name, which you want to update.

## Parameters

### -Description

Specifies a description.

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

### -DisplayName

Specifies a display name.

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

Specifies the ID of an administrative unit in Microsoft Entra ID

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

## Outputs

## Notes

## Related Links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)
