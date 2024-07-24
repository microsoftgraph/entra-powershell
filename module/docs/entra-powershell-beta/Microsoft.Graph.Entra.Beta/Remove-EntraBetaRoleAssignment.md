---
title: Remove-EntraBetaRoleAssignment
description: This article provides details on the Remove-EntraBetaRoleAssignment command.


ms.topic: reference
ms.date: 07/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaRoleAssignment

## Synopsis

Delete a Microsoft Entra ID roleAssignment.

## Syntax

```powershell
Remove-EntraBetaRoleAssignment 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaRoleAssignment` cmdlet removes a role assignment from Microsoft Entra ID.

## Examples

### Example 1: Remove a role assignment

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.ReadWrite.All' #For the entitlement management provider
 Remove-EntraBetaRoleAssignment -Id 'Y1vFBcN4i0e3ngdNDocmngJAWGnAbFVAnJQyBBLv1lM-1'
```

This example removes the specified role assignment from Microsoft Entra ID.

- `-Id` parameter specifies the role assignment ID.

## Parameters

### -Id

The unique identifier of an object in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[New-EntraBetaRoleAssignment](New-EntraBetaRoleAssignment.md)

[Get-EntraBetaRoleAssignment](Get-EntraBetaRoleAssignment.md)
