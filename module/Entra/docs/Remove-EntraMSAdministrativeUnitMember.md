---
title: Remove-EntraMSAdministrativeUnitMember
description: This article provides details on the Remove-EntraMSAdministrativeUnitMember command.

ms.service: active-directory
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
    [-InformationAction <ActionPreference>] 
    [-InformationVariable <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraMSAdministrativeUnitMember** cmdlet removes an administrative unit member in Microsoft Entra ID.

## EXAMPLES

### Example 1 : Remove an administrative unit
```powershell
PS C:\> Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
```

This command removes a specified member from a specified administrative unit.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.

The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraMSAdministrativeUnitMember](Add-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)

