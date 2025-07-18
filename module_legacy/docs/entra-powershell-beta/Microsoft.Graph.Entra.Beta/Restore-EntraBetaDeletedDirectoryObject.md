---
title: Restore-EntraBetaDeletedDirectoryObject
description: This article provides details on the Restore-EntraBetaDeletedDirectoryObject command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Restore-EntraBetaDeletedDirectoryObject

schema: 2.0.0
---

# Restore-EntraBetaDeletedDirectoryObject

## Synopsis

Restore a previously deleted object.

## Syntax

```powershell
Restore-EntraBetaDeletedDirectoryObject
 -Id <String>
 [-AutoReconcileProxyConflict]
 [<CommonParameters>]
```

## Description

The `Restore-EntraBetaDeletedDirectoryObject` cmdlet is used to restore previously deleted objects, such as application, group, service principal, administrative unit, or user objects.

When a group or application is deleted, it is initially soft deleted and can be recovered within the first 30 days. After 30 days, the deleted object is permanently deleted and cannot be recovered.

**Notes:**

- Only Unified Groups (also known as Office 365 Groups) can be restored; Security groups cannot be restored.
- Restoring an application does not automatically restore its associated service principal. You must explicitly use this cmdlet to restore the deleted service principal.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles:

- **To restore deleted applications or service principals:** Application Administrator, Cloud Application Administrator, or Hybrid Identity Administrator.
- **To restore deleted users:** User Administrator.
  - However, to restore users with privileged administrator roles:
    - In delegated scenarios, the app must be assigned the `Directory.AccessAsUser.All` delegated permission, and the calling user must also be assigned a higher privileged administrator role.
    - In app-only scenarios, in addition to being granted the `User.ReadWrite.All` application permission, the app must be assigned a higher privileged administrator role.
- **To restore deleted groups:** Groups Administrator.
  - However, to restore role-assignable groups, the calling user must be assigned the Privileged Role Administrator role.

## Examples

### Example 1: Restore a deleted object with ID

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All' #administrativeUnit resource
Connect-Entra -Scopes 'Application.ReadWrite.All' #application resource
Connect-Entra -Scopes 'Group.ReadWrite.All' #group resource
Connect-Entra -Scopes 'Application.ReadWrite.All' #servicePrincipal resource
Connect-Entra -Scopes 'User.ReadWrite.All' #user resource
Restore-EntraBetaDeletedDirectoryObject -Id 'dddddddd-3333-4444-5555-eeeeeeeeeeee'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example shows how to restore a deleted object in Microsoft Entra ID.

- `-Id` parameter specifies the Id of the directory object to restore.

### Example 2: Restoring a Soft-Deleted User and Removing Conflicting Proxy Addresses

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Restore-EntraBetaDeletedDirectoryObject -Id 'dddddddd-3333-4444-5555-eeeeeeeeeeee' -AutoReconcileProxyConflict
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example shows how to restore a deleted object in Microsoft Entra ID.

- `-Id` parameter specifies the Id of the directory object to restore.
- `-AutoReconcileProxyConflict` parameter removes any conflicting proxy addresses while restoring a soft-deleted user whose one or more proxy addresses are currently used for an active user.

## Parameters

### -Id

The Id of the directory object to restore.

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

### -AutoReconcileProxyConflict

Specifies whether Microsoft Entra ID should remove conflicting proxy addresses when restoring a soft-deleted user, if any of the user's proxy addresses are currently in use by an active user. This parameter applies only when restoring a soft-deleted user. The default value is `false`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

[Remove-EntraBetaDeletedApplication](Remove-EntraBetaDeletedApplication.md)

[Restore-EntraBetaDeletedApplication](Restore-EntraBetaDeletedApplication.md)

[Remove-EntraBetaDeletedDirectoryObject](Remove-EntraBetaDeletedDirectoryObject.md)

[Get-EntraBetaDeletedApplication](Get-EntraBetaDeletedApplication.md)

[Get-EntraBetaDeletedDirectoryObject](Get-EntraBetaDeletedDirectoryObject.md)
