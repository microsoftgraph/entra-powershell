---
title: Get-EntraContactDirectReport
description: This article provides details on the Get-EntraContactDirectReport command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraContactDirectReport

## Synopsis
get the direct reports for a contact.

## Syntax

```powershell
Get-EntraContactDirectReport 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description
the Get-EntraContactDirectReport cmdlet gets the direct reports for a contact.

## Examples

### Example 1: Get the direct reports of a contact
```powershell
PS C:\> $Contact = Get-EntraContact -Top 1
PS C:\> Get-EntraContactDirectReport -ObjectId $Contact.ObjectId
```

The first command gets a contact by using the [Get-EntraContact](./Get-EntraContact.md) cmdlet, and then stores it in the $Contact variable.  

The second command gets the direct reports for $Contact.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a contact in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

## Related Links

[Get-EntraContact](Get-EntraContact.md)