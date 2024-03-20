---
title: Remove-EntraBetaObjectSetting.
description: This article provides details on the Remove-EntraBetaObjectSetting command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
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
The **Remove-EntraBetaObjectSetting** cmdlet removes object settings in Microsoft Entra ID.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-EntraBetaObjectSetting -TargetType Groups -TargetObjectId "ec83af6b-bb96-4d2e-8ad5-f21f4f613400" -Id bd56f3f2-5589-464c-9e69-58da3003ff2e
```

This command removes the specified setting.

## PARAMETERS

### -Id
Specfies the ID of a settings object in Microsoft Entra ID.

```yaml
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaObjectSetting](Get-EntraBetaObjectSetting.md)

[New-EntraBetaObjectSetting](New-EntraBetaObjectSetting.md)

[Set-EntraBetaObjectSetting](Set-EntraBetaObjectSetting.md)

