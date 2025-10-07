---
author: msewaweru
description: This article provides details on the Remove-EntraBetaObjectSetting command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 08/08/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Remove-EntraBetaObjectSetting
schema: 2.0.0
title: Remove-EntraBetaObjectSetting
---

# Remove-EntraBetaObjectSetting

## SYNOPSIS

Deletes settings in Microsoft Entra ID.

## SYNTAX

```powershell
Remove-EntraBetaObjectSetting
 -Id <String>
 -TargetType <String>
 -TargetObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaObjectSetting` cmdlet removes object settings in Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes object settings

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$params = @{
    TargetType = 'Groups'
    TargetObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Remove-EntraBetaObjectSetting @params
```

This example removes object settings from Microsoft Entra ID

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.
- `-Id` Parameter specifies the ID of a settings object.

## PARAMETERS

### -Id

Specifies the ID of a settings object in Microsoft Entra ID.

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

### -TargetObjectId

Specifies the object ID of the target.

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

### -TargetType

Specifies the target type.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaObjectSetting](Get-EntraBetaObjectSetting.md)

[New-EntraBetaObjectSetting](New-EntraBetaObjectSetting.md)

[Set-EntraBetaObjectSetting](Set-EntraBetaObjectSetting.md)
