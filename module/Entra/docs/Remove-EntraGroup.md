---
title: Remove-EntraGroup
description: This article provides details on the Remove-EntraGroup command.

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

# Remove-EntraGroup

## SYNOPSIS
Removes a group.

## SYNTAX

```
Remove-EntraGroup 
-ObjectId <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraGroup cmdlet removes a group from Microsoft Entra ID.
Note that a Unified Group can be restored withing 30 days after deletion using the Restore-EntraMSDeletedDirectoryObject cmdlet.
Security groups cannot be restored after deletion.

## EXAMPLES

### Example 1: Remove a group

```powershell
PS C:\>Remove-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606"
```
This example removes the specified group from Microsoft Entra ID.

## PARAMETERS

### -ObjectId
Specifies the object ID of a group in Microsoft Entra ID.

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

[Get-EntraGroup](Get-EntraGroup.md)

[New-EntraGroup](New-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)

