---
title: Remove-EntraBetaMSAdministrativeUnitMember
description: This article provides details on the Remove-EntraBetaMSAdministrativeUnitMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaMSAdministrativeUnitMember

## Synopsis
Removes an administrative unit member.

## Syntax

```powershell
Remove-EntraBetaMSAdministrativeUnitMember 
    -Id <String> 
    -MemberId <String>
 [<CommonParameters>]
```

## Description
The **Remove-EntraBetaMSAdministrativeUnitMember** cmdlet removes an administrative unit member in Microsoft Entra ID.

## Examples

### Example 1: Remove an administrative unit
```powershell
PS C:\> Remove-EntraBetaMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
```

This command removes a specified member from a specified administrative unit.

## Parameters

### -MemberId
Specifies the ID of the administrative unit member.

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

### -Id
Specifies the ID of an administrative unit in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Add-EntraBetaMSAdministrativeUnitMember](Add-EntraBetaMSAdministrativeUnitMember.md)

[Remove-EntraBetaMSAdministrativeUnitMember](Remove-EntraBetaMSAdministrativeUnitMember.md)

