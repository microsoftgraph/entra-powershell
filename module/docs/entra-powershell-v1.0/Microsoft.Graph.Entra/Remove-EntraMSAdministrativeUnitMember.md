---
title: Remove-EntraMSAdministrativeUnitMember
description: This article provides details on the Remove-EntraMSAdministrativeUnitMember command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSAdministrativeUnitMember

## SYNOPSIS
Removes an administrative unit member.

## SYNTAX

```powershell
Remove-EntraMSAdministrativeUnitMember 
 -Id <String> 
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraMSAdministrativeUnitMember cmdlet removes an administrative unit member in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an administrative unit
```powershell
PS C:\> Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
```

This command removes a specified member from a specified administrative unit.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraMSAdministrativeUnitMember](Add-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)

