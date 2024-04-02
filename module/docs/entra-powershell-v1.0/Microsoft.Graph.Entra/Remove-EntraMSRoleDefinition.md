---
title: Remove-EntraMSRoleDefinition
description: This article provides details on the Remove-EntraMSRoleDefinition command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSRoleDefinition

## SYNOPSIS
Delete a Microsoft Entra ID roleDefinition by objectId.

## SYNTAX

```
Remove-EntraMSRoleDefinition 
-Id <String> 
[<CommonParameters>]
```

## DESCRIPTION
Delete a Microsoft Entra ID roleDefinition object by ID.
For more info, see https://go.microsoft.com/fwlink/?linkid=2097519.

## EXAMPLES

### Example 1: Remove a specified role definition.

```powershell
PS C:\> Remove-EntraMSRoleDefinition  -Id 62e90894-69f5-4237-9190-012177145e10
```
This example demonstrates how to remove the specified role definition from Microsoft Entra ID.

## PARAMETERS

### -Id
The unique identifier of an object in Microsoft Entra ID.

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

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSRoleDefinition](Get-EntraMSRoleDefinition.md)

[New-EntraMSRoleDefinition](New-EntraMSRoleDefinition.md)

[Set-EntraMSRoleDefinition](Set-EntraMSRoleDefinition.md)

