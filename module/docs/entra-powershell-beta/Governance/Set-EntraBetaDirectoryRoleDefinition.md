---
author: msewaweru
description: This article provides details on the Set-EntraBetaDirectoryRoleDefinition command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Governance
ms.author: eunicewaweru
ms.date: 07/22/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Governance/Set-EntraBetaDirectoryRoleDefinition
schema: 2.0.0
title: Set-EntraBetaDirectoryRoleDefinition
---

# Set-EntraBetaDirectoryRoleDefinition

## SYNOPSIS

Update an existing Microsoft Entra ID roleDefinition.

## SYNTAX

```powershell
Set-EntraBetaDirectoryRoleDefinition
 -UnifiedRoleDefinitionId <String>
 [-IsEnabled <Boolean>]
 [-InheritsPermissionsFrom <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition]>]
 [-Version <String>]
 [-ResourceScopes <System.Collections.Generic.List`1[System.String]>]
 [-Description <String>]
 [-RolePermissions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]>]
 [-TemplateId <String>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Updates a Microsoft Entra roleDefinition object identified by ID. You can't update built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Update an roleDefinition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraBetaDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -DisplayName 'UpdatedDisplayName'
```

This example updates the specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-DisplayName` parameter specifies the display name for the role definition.

### Example 2: Update an roleDefinition with Description

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraBetaDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -Description 'MYROLEUPDATE1S'
```

This example updates the Description of specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-Description` parameter specifies the description for the role definition.

### Example 3: Update an roleDefinition with IsEnabled

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraBetaDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -IsEnabled $true
```

This example updates the IsEnabled of specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-IsEnabled` parameter specifies whether the role definition is enabled.

### Example 4: Update an roleDefinition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
$rolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
$rolePermissions.AllowedResourceActions = @("microsoft.directory/applications/standard/read")
$params = @{
    UnifiedRoleDefinitionId = $roleDefinition.Id
    Description             = 'Update'
    DisplayName             = 'Update'
    ResourceScopes          = '/'
    IsEnabled               = $false
    RolePermissions         = $rolePermissions
    TemplateId              = 'f2ef992c-3afb-46b9-b7cf-a126ee74c451'
    Version                 = 2
}
Set-EntraBetaDirectoryRoleDefinition @params
```

This example updates the RolePermissions, TemplateId, TemplateId, ResourceScopes  of specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-RolePermissions` parameter specifies the permissions for the role definition.
- `-IsEnabled` parameter specifies whether the role definition is enabled.
- `-DisplayName` parameter specifies the display name for the role definition.
- `-Description` parameter specifies the description for the role definition.
- `-ResourceScopes` parameter specifies the resource scopes for the role definition.
- `-TemplateId` parameter specifies the template ID for the role definition.
- `-Version` parameter specifies the version for the role definition.

## PARAMETERS

### -Description

Specifies a description for the role definition.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies a display name for the role definition.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnifiedRoleDefinitionId

Specifies the roleDefinition object ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InheritsPermissionsFrom

Read-only collection of role definitions that the given role definition inherits from. Only Microsoft Entra built-in roles support this attribute.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsEnabled

Specifies whether the role definition is enabled. Flag indicating if the role is enabled for assignment. If false, the role is not available for assignment. Read-only when `isBuiltIn` is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceScopes

Specifies the resource scopes for the role definition.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RolePermissions

Specifies permissions for the role definition. List of permissions included in the role. Read-only when `isBuiltIn` is `true`.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateId

Specifies the template ID for the role definition. A custom template ID can be set when `isBuiltIn` is `false`. This ID is typically used to keep the same identifier across different directories. It is read-only when `isBuiltIn` is `true`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version

Specifies version for the role definition. Indicates version of the role definition. Read-only when `isBuiltIn` is `true`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

`Set-EntraBetaRoleAssignment` is an alias for `Set-EntraBetaDirectoryRoleAssignment`.

## RELATED LINKS

[New-EntraBetaDirectoryRoleDefinition](New-EntraBetaDirectoryRoleDefinition.md)

[Remove-EntraBetaDirectoryRoleDefinition](Remove-EntraBetaDirectoryRoleDefinition.md)

[Get-EntraBetaDirectoryRoleDefinition](Get-EntraBetaDirectoryRoleDefinition.md)
