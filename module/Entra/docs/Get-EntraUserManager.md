---
title: Get-EntraUserManager.
description: This article provides details on the Get-EntraUserManager command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserManager

## SYNOPSIS
Gets the manager of a user.

## SYNTAX

```
Get-EntraUserManager 
 -ObjectId <String> 
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the manager of a user
```
PS C:\>Get-EntraUserManager -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"


```

This command gets the manager of the specified user.

### Example 2: Get the manager of a user
```
PS C:\>Get-EntraUserManager -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -InformationAction Continue -InformationVariable "Test"

```

This command gets the manager of the specified user for the specified information action and information variable.

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

### -ObjectId
The unique identifier of a user in Microsoft Entra ID (UPN or ObjectId)

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

[Remove-EntraUserManager]()

[Set-EntraUserManager]()

