---
author: msewaweru
description: This article provides details on the Remove-EntraBetaUserAppRoleAssignment command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaUserAppRoleAssignment
schema: 2.0.0
title: Remove-EntraBetaUserAppRoleAssignment
---

# Remove-EntraBetaUserAppRoleAssignment

## Synopsis

Removes a user application role assignment.

## Syntax

```powershell
Remove-EntraBetaUserAppRoleAssignment
 -UserId <String>
 -AppRoleAssignmentId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaUserAppRoleAssignment` cmdlet removes a user application role assignment in Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. Supported roles include:

- Directory Synchronization Accounts (for Entra Connect and Cloud Sync)
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## Examples

### Example 1: Remove user app role assignment

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$assignment = Get-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@Contoso.com' | 
Where-Object { $_.ResourceDisplayName -eq 'Helpdesk Application' -and $_.PrincipalType -eq 'User' }
Remove-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@Contoso.com' -AppRoleAssignmentId $assignment.Id
```

This example demonstrates how to Remove the user app role assignment in Microsoft Entra ID.

- `-UserId` parameter specifies the user ID.
- `-AppRoleAssignmentId` parameter specifies the application role assignment ID.

Use the `Get-EntraBetaUserAppRoleAssignment` cmdlet to get `AppRoleAssignmentId` details.

## Parameters

### -AppRoleAssignmentId

Specifies the ID of an application role assignment.

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

### -UserId

Specifies the ID (as a UserPrincipleName or ObjectId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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

## Related links

[Get-EntraBetaUserAppRoleAssignment](Get-EntraBetaUserAppRoleAssignment.md)

[New-EntraBetaUserAppRoleAssignment](New-EntraBetaUserAppRoleAssignment.md)
