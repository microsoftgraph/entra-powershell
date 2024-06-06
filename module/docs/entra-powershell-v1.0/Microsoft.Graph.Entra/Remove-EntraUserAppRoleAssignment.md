---
title: Remove-EntraUserAppRoleAssignment.
description: This article provides details on the Remove-EntraUserAppRoleAssignment command.

ms.service: entra
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraUserAppRoleAssignment

## SYNOPSIS
Removes a user application role assignment.

## SYNTAX

```powershell
Remove-EntraUserAppRoleAssignment
 -AppRoleAssignmentId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraUserAppRoleAssignment cmdlet removes a user application role assignment in Microsoft Entra ID.

## EXAMPLES

### Example 1
```powershell
PS C:\>  Remove-EntraUserAppRoleAssignment -ObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 -AppRoleAssignmentId Idn1u1K7S0OWoJWIjkT69ZuAI6_HyiZJv_bPBryomlg
```

This example demonstrates how to Remove the user app role assignment in Microsoft Entra ID.   

## PARAMETERS

### -AppRoleAssignmentId
Specifies the ID of an application role assignment.

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
Specifies the ID (as a User Principal Name or ObjectId) of a user in Microsoft Entra ID.

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

[Get-EntraUserAppRoleAssignment](Get-EntraUserAppRoleAssignment.md)

[New-EntraUserAppRoleAssignment](New-EntraUserAppRoleAssignment.md)

