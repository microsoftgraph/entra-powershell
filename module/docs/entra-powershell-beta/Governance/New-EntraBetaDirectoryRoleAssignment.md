---
description: This article provides details on the New-EntraBetaDirectoryRoleAssignment command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/24/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaDirectoryRoleAssignment
schema: 2.0.0
title: New-EntraBetaDirectoryRoleAssignment
---

# New-EntraBetaDirectoryRoleAssignment

## SYNOPSIS

Create a new Microsoft Entra ID roleAssignment.

## SYNTAX

```powershell
New-EntraBetaDirectoryRoleAssignment
 -RoleDefinitionId <String>
 -DirectoryScopeId <String>
 -PrincipalId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaDirectoryRoleAssignment` cmdlet creates a new Microsoft Entra role assignment.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Create a new Microsoft Entra ID role assignment

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory', 'EntitlementManagement.ReadWrite.All'
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$role = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq 'Helpdesk Administrator'"
New-EntraBetaDirectoryRoleAssignment -RoleDefinitionId $role.Id -PrincipalId $user.Id -DirectoryScopeId '/'
```

```Output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u aaaaaaaa-bbbb-cccc-1111-222222222222 a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 /
```

This command creates a new role assignment in Microsoft Entra ID.

- `-RoleDefinitionId` parameter specifies the ID of the role definition that you want to assign. Role definitions describe the permissions that are granted to users or groups by the role. This is the Identifier of the `unifiedRoleDefinition` the assignment is for.
- `-PrincipalId` parameter specifies the ID of the principal (user, group, or service principal) to whom the role is being assigned.
- `-DirectoryScopeId` parameter specifies the scope of the directory over which the role assignment is effective. The '/' value typically represents the root scope, meaning the role assignment is applicable across the entire directory.

## PARAMETERS

### -DirectoryScopeId

Specifies the scope for the role assignment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrincipalId

Specifies the principal for role assignment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleDefinitionId

Specifies the role definition for role assignment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment

## NOTES

`New-EntraBetaRoleAssignment` is an alias for `New-EntraBetaDirectoryRoleAssignment`.

## RELATED LINKS

[Get-EntraBetaDirectoryRoleAssignment](Get-EntraBetaDirectoryRoleAssignment.md)

[Remove-EntraBetaDirectoryRoleAssignment](Remove-EntraBetaDirectoryRoleAssignment.md)
