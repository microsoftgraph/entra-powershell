---
title: Remove-EntraMSRoleAssignment
description: This article provides details on the Remove-EntraMSRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSRoleAssignment

## SYNOPSIS
Delete a Microsoft Entra ID roleAssignment.

## SYNTAX

```powershell
Remove-EntraMSRoleAssignment 
    -Id <String> 
    [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraMSRoleAssignment** cmdlet removes a role assignment from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a role assignment
```powershell
PS C:\> Remove-EntraMSRoleAssignment -Id Y1vFBcN4i0e3ngdNDocmngJAWGnAbFVAnJQyBBLv1lM-1
```

Removes the specified role assignment from Microsoft Entra ID.

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

## OUTPUTS

## NOTES

## RELATED LINKS
