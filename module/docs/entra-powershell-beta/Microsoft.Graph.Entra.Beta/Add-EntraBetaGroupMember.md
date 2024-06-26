---
title: Add-EntraBetaGroupMember.
description: This article provides details on the Add-EntraBetaGroupMember command.

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

# Add-EntraBetaGroupMember

## Synopsis
Adds a member to a group.

## Syntax

```powershell
Add-EntraBetaGroupMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description
The Add-EntraBetaGroupMember cmdlet adds a member to a group.

## Examples

### Example 1: Add a member to a group
```powershell
PS C:\> Add-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
```
This command adds a member to a group.

## Parameters

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
Specifies the ID of the Microsoft Entra ID object that assigned as owner/manager/member.

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

[Get-EntraBetaGroupMember](Get-EntraBetaGroupMember.md)

[Remove-EntraBetaGroupMember](Remove-EntraBetaGroupMember.md)