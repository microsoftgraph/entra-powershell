---
title: Remove-EntraGroupOwner
description: This article provides details on the Remove-EntraGroupOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraGroupOwner

## SYNOPSIS
Removes an owner from a group.

## SYNTAX

```
Remove-EntraGroupOwner 
-OwnerId <String> 
-ObjectId <String> 
[-InformationAction <ActionPreference>]
[-InformationVariable <String>] 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraGroupOwner cmdlet removes an owner from a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner
This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

```powershell
PS C:\>Remove-EntraGroupOwner -ObjectId "62438306-7c37-4638-a72d-0ee8d9217680" -OwnerId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
```

This example removes a specified owner from a group. 

ObjectID - Specifies the ID of a group in Microsoft Entra ID.  

OwnerId  - Specifies the ID of an owner.

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
Specifies the ID of a group in Microsoft Entra ID.

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

### -OwnerId
Specifies the ID of an owner.

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

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)