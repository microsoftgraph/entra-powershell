---
title: Remove-EntraServicePrincipalAppRoleAssignment
description: This article provides details on the Remove-EntraServicePrincipalAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipalAppRoleAssignment

schema: 2.0.0
---

# Remove-EntraServicePrincipalAppRoleAssignment

## Synopsis

Removes a service principal application role assignment.

## Syntax

```powershell
Remove-EntraServicePrincipalAppRoleAssignment
 -AppRoleAssignmentId <String>
 -ServicePrincipalId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraServicePrincipalAppRoleAssignment` cmdlet removes a service principal application role assignment in Microsoft Entra ID.

App roles which are assigned to service principals are also known as application permissions. Deleting an app role assignment for a service principal is equivalent to revoking the app-only permission grant.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Synchronization Accounts
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## Examples

### Example 1: Removes a service principal application role assignment

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id  -AppRoleAssignmentId '2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6'
```

This example demonstrates how to remove a service principal application role assignment in Microsoft Entra ID.

- `-ServicePrincipalId` - specifies the unique identifier (Object ID) of the service principal or user from which you want to remove an app role assignment.
- `-AppRoleAssignmentId` - specifies the unique identifier (ID) of the app role assignment that you want to remove. The value `2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6` represents the ID of the specific app role assignment to be removed.

## Parameters

### -AppRoleAssignmentId

Specifies the ID of the application role assignment.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

`Remove-EntraServiceAppRoleAssignment` is an alias for `Remove-EntraServicePrincipalAppRoleAssignment`.

## Related Links

[Get-EntraServicePrincipalAppRoleAssignment](Get-EntraServicePrincipalAppRoleAssignment.md)

[New-EntraServicePrincipalAppRoleAssignment](New-EntraServicePrincipalAppRoleAssignment.md)
