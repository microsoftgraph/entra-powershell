---
title: Add-EntraGroupMember.
description: This article provides details on the Add-EntraGroupMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraGroupMember

## SYNOPSIS
Adds a member to a group.

## SYNTAX

```powershell
Add-EntraGroupMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraGroupMember cmdlet adds a member to a group.

## EXAMPLES

### Example 1: Add a member to a group

```powershell
PS C:\>Add-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
```
This command adds a member to a group.

## PARAMETERS

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

### -RefObjectId
Specifies the ID of the Microsoft Entra ID object that assign as owner/manager/member.

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

[Get-EntraGroupMember](Get-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)

