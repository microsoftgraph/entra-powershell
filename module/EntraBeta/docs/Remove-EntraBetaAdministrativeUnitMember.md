---
title: Remove-EntraBetaAdministrativeUnitMember
description: This article provides details on the Remove-EntraBetaAdministrativeUnitMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaAdministrativeUnitMember

## SYNOPSIS
Removes an administrative unit member.

## SYNTAX

```
Remove-EntraBetaAdministrativeUnitMember -ObjectId <String> -MemberId <String>
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraBetaAdministrativeUnitMember** cmdlet removes an administrative unit member in Microsoft Entra ID.

## EXAMPLES

### Example 1
```
PS C:\> Remove-AzureADAdministrativeUnitMember -ObjectId "49263478-3dda-4112-821d-4e6ccaa1c2d5" -MemberId "c26aa946-90cd-4e9a-a8f1-43eeef655500"
```

This command removes an administrative unit member in Microsoft Entra ID. 

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

### -ObjectId
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

[Add-EntraBetaAdministrativeUnitMember](./Add-EntraBetaAdministrativeUnitMember.md)

[Remove-EntraBetaAdministrativeUnitMember](./Remove-EntraBetaAdministrativeUnitMember.md)

