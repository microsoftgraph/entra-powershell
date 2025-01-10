---
title: Set-EntraDirectoryRoleDefinition
description: This article provides details on the Set-EntraDirectoryRoleDefinition command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Governance-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraDirectoryRoleDefinition

schema: 2.0.0
---

# Set-EntraDirectoryRoleDefinition

## Synopsis

Update an existing Microsoft Entra ID roleDefinition.

## Syntax

```powershell
Set-EntraDirectoryRoleDefinition
 [-TemplateId <String>]
 [-DisplayName <String>]
 [-RolePermissions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]>]
 -UnifiedRoleDefinitionId <String>
 [-Description <String>]
 [-Version <String>]
 [-IsEnabled <Boolean>]
 [-ResourceScopes <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

Updates a Microsoft Entra roleDefinition object identified by ID. You can't update built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## Examples

### Example 1: Update an roleDefinition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -DisplayName 'UpdatedDisplayName'
```

This example updates the specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-DisplayName` parameter specifies the display name for the role definition.

### Example 2: Update an roleDefinition with Description

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -Description 'MYROLEUPDATE1S'
```

This example updates the Description of specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-Description` parameter specifies the description for the role definition.

### Example 3: Update an roleDefinition with IsEnabled

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId $roleDefinition.Id -IsEnabled $true
```

This example updates the IsEnabled of specified role definition in Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.
- `-IsEnabled` parameter specifies whether the role definition is enabled.

### Example 4: Update an roleDefinition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$roleDefinition = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq '<Role-Definition-Name>'"
$RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
$RolePermissions.AllowedResourceActions = @("microsoft.directory/applications/standard/read")
$params = @{
   UnifiedRoleDefinitionId = $roleDefinition.Id
   Description = 'Update'
   DisplayName = 'Update'
   ResourceScopes = '/'
   IsEnabled = $false
   RolePermissions = $RolePermissions
   TemplateId = '54d418b2-4cc0-47ee-9b39-e8f84ed8e073'
   Version = 2
}

Set-EntraDirectoryRoleDefinition @params
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

## Parameters

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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

`Set-EntraRoleDefinition` is an alias for `Set-EntraDirectoryRoleDefintion`.

## Related Links

[Get-EntraDirectoryRoleDefinition](Get-EntraDirectoryRoleDefinition.md)

[New-EntraDirectoryRoleDefinition](New-EntraDirectoryRoleDefinition.md)
