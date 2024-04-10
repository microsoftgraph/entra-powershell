---
title: Remove-EntraGroupAppRoleAssignment
description: This article provides details on the Remove-EntraGroupAppRoleAssignment command.

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

# Remove-EntraGroupAppRoleAssignment

## SYNOPSIS
Delete a group application role assignment.

## SYNTAX

```powershell
Remove-EntraGroupAppRoleAssignment 
 -AppRoleAssignmentId <String> 
 -ObjectId <String>
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraGroupAppRoleAssignment cmdlet removes a group application role assignment from Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes a group application role assignment
```powershell
PS C:\> Remove-AzureADGroupAppRoleAssignment -ObjectId 0877c6c6-fc99-4d51-9871-8335be7cfc9d -AppRoleAssignmentId xsZ3CJn8UU2YcYM1vnz8nXBBPlQgBApOqrWsVNJlsa4
```

This example demonstrates how to remove the specified group application role assignment.    
ObjectId - Specifies the object ID of a group.    
AppRoleAssignmentId - Specifies the object ID of the group application role assignment.

## PARAMETERS

### -AppRoleAssignmentId
Specifies the object ID of the group application role assignment.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroupAppRoleAssignment](Get-EntraGroupAppRoleAssignment.md)

[New-EntraGroupAppRoleAssignment](New-EntraGroupAppRoleAssignment.md)

