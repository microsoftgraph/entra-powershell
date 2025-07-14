---
author: msewaweru
description: This article provides details on the Restore-EntraDeletedDirectoryObject command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Restore-EntraDeletedDirectoryObject
schema: 2.0.0
title: Restore-EntraDeletedDirectoryObject
---

# Restore-EntraDeletedDirectoryObject

## Synopsis

Restore a previously deleted object.

## Syntax

```powershell
Restore-EntraDeletedDirectoryObject
 -Id <String>
 [-AutoReconcileProxyConflict]
 [-NewUserPrincipalName <String>]
 [<CommonParameters>]
```

## Description

The `Restore-EntraDeletedDirectoryObject` cmdlet is used to restore previously deleted objects, such as application, group, service principal, administrative unit, or user objects.

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
Connect-Entra -Scopes 'User.ReadWrite.All', 'AdministrativeUnit.ReadWrite.All', 'Application.ReadWrite.All', 'Group.ReadWrite.All'
$deletedUser = Get-EntraDeletedUser -Filter "DisplayName eq 'Adele Vance'"
Restore-EntraDeletedDirectoryObject -Id $deletedUser.Id
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
$deletedUser = Get-EntraDeletedUser -Filter "DisplayName eq 'Adele Vance'"
Restore-EntraDeletedDirectoryObject -Id $deletedUser.Id -AutoReconcileProxyConflict
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example shows how to restore a deleted object in Microsoft Entra ID.

- `-Id` parameter specifies the Id of the directory object to restore.
- `-AutoReconcileProxyConflict` parameter removes any conflicting proxy addresses while restoring a soft-deleted user whose one or more proxy addresses are currently used for an active user.

### Example 3: Restoring a Deleted User and assigning a new UserPrincipalName

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$deletedUser = Get-EntraBetaDeletedUser -Filter "DisplayName eq 'Sawyer M'"
Restore-EntraBetaDeletedDirectoryObject -Id $deletedUser.Id -NewUserPrincipalName 'SawyerM@contoso.com'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example shows how to restore a deleted object in Microsoft Entra ID.

- `-Id` parameter specifies the Id of the directory object to restore.
- `-NewUserPrincipalName` assigns a new UserPrincipalName to the restored user.

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

### -NewUserPrincipalName

The user principal name (UPN) assigned to the restored user.

The UPN is an Internet-style sign-in name for the user based on the Internet standard RFC 822.

By convention, this UPN should map to the user's email name.

The general format is "alias@domain".

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[Remove-EntraDeletedApplication](../Applications/Remove-EntraDeletedApplication.md)

[Restore-EntraDeletedApplication](../Applications/Restore-EntraDeletedApplication.md)

[Remove-EntraDeletedDirectoryObject](Remove-EntraDeletedDirectoryObject.md)

[Get-EntraDeletedApplication](../Applications/Get-EntraDeletedApplication.md)

[Get-EntraDeletedDirectoryObject](Get-EntraDeletedDirectoryObject.md)
