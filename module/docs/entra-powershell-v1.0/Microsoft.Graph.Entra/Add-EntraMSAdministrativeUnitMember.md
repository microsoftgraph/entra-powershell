---
title: Add-EntraMSAdministrativeUnitMember
description: This article provides details on the Add-EntraMSAdministrativeUnitMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSAdministrativeUnitMember

## SYNOPSIS
Adds an administrative unit member.

## SYNTAX

```powershell
Add-EntraMSAdministrativeUnitMember 
    -RefObjectId <String> 
    -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The **Add-EntraMSAdministrativeUnitMember** cmdlet adds a Microsoft Entra ID administrative unit member.

## EXAMPLES

### Example 1: Add user as an administrative unit member
```powershell
PS C:\>Add-EntraMSAdministrativeUnitMember -Id f306a126-cf2e-439d-b20f-95ce4bcb7ffa -RefObjectId d6873b36-81d6-4c5e-bec0-9e3ca2c86846
```

This command adds a user as an administrative unit member.

## PARAMETERS

### -Id
Specifies the ID of a Microsoft Entra ID administrative unit.

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

### -RefObjectId
Specifies the unique ID of the specific Microsoft Entra ID object that are as owner/manager/member.

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

[Get-EntraMSAdministrativeUnitMember](Get-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)

