---
title: New-EntraMSAdministrativeUnit
description: This article provides details on the New-EntraMSAdministrativeUnit command.

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

# New-EntraMSAdministrativeUnit

## SYNOPSIS
Creates an administrative unit.

## SYNTAX

```
New-EntraMSAdministrativeUnit -DisplayName <String> [-Description <String>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The New-EntraMSAdministrativeUnit cmdlet creates an administrative unit in Microsoft Entra ID.

## EXAMPLES

### Example 1
```
PS C:\> New-EntraMSAdministrativeUnit -DisplayName "TestAU"

DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                eb7dee2b-4938-4835-b3e1-bb8207ae0814             TestAU
```

### Example 2
```
PS C:\> New-EntraMSAdministrativeUnit -Description "test111" -DisplayName "test111"

DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                eb7dee2b-4938-4835-b3e1-bb8207ae0814 test111     test111
```

## PARAMETERS

### -Description
Specifies a description for the new administrative unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name of the new administrative unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAdministrativeUnit](Get-EntraMSAdministrativeUnit.md)

[Remove-EntraMSAdministrativeUnit](Remove-EntraMSAdministrativeUnit.md)

[Set-EntraMSAdministrativeUnit](Set-EntraMSAdministrativeUnit.md)

