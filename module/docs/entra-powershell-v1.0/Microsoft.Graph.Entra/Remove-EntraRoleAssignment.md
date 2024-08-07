---
title: Remove-EntraRoleAssignment
description: This article provides details on the Remove-EntraRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraRoleAssignment

schema: 2.0.0
---

# Remove-EntraRoleAssignment

## Synopsis

Delete a Microsoft Entra ID roleAssignment.

## Syntax

```powershell
Remove-EntraRoleAssignment 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Remove-EntraRoleAssignment` cmdlet removes a role assignment from Microsoft Entra ID.

## Examples

### Example 1: Remove a role assignment

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.ReadWrite.All' #For the entitlement management provider
 Remove-EntraRoleAssignment -Id Y1vFBcN4i0e3ngdNDocmngJAWGnAbFVAnJQyBBLv1lM-1
```

Removes the specified role assignment from Microsoft Entra ID.

## Parameters

### -Id

The unique identifier of an object in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraRoleAssignment](Get-EntraRoleAssignment.md)

[New-EntraRoleAssignment](New-EntraRoleAssignment.md)
