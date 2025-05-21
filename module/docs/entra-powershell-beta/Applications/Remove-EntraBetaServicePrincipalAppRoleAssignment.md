---
title: Remove-EntraBetaServicePrincipalAppRoleAssignment
description: This article provides details on the Remove-EntraBetaServicePrincipalAppRoleAssignment command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaServicePrincipalAppRoleAssignment

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalAppRoleAssignment

## Synopsis

Removes a service principal application role assignment.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalAppRoleAssignment
 -ServicePrincipalId <String>
 -AppRoleAssignmentId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipalAppRoleAssignment` cmdlet removes a service principal application role assignment in Microsoft Entra ID.

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
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$group = Get-EntraBetaGroup -Filter "displayName eq 'Contoso marketing'"
$assignment = Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id | Where-Object {$_.PrincipalId -eq $group.Id} 
Remove-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id  -AppRoleAssignmentId $assignment.Id
```

This example demonstrates how to remove a service principal application role assignment for a group in Microsoft Entra ID.

- `-ServicePrincipalId` - specifies the unique identifier (Object ID) of the service principal or user from which you want to remove an app role assignment.
- `-AppRoleAssignmentId` - specifies the unique identifier (ID) of the app role assignment that you want to remove.

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

`Remove-EntraBetaServiceAppRoleAssignment` is an alias for `Remove-EntraBetaServicePrincipalAppRoleAssignment`.

## Related links

[Get-EntraBetaServicePrincipalAppRoleAssignment](Get-EntraBetaServicePrincipalAppRoleAssignment.md)

[New-EntraBetaServicePrincipalAppRoleAssignment](New-EntraBetaServicePrincipalAppRoleAssignment.md)
