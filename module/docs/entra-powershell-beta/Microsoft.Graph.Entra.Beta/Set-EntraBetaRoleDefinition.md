---
title: Set-EntraBetaRoleDefinition.
description: This article provides details on the Set-EntraBetaRoleDefinition command.


ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaRoleDefinition

schema: 2.0.0
---

# Set-EntraBetaRoleDefinition

## Synopsis

Update an existing Microsoft Entra ID roleDefinition.

## Syntax

```powershell
Set-EntraBetaRoleDefinition 
 -Id <String>
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

## Description

Updates a Microsoft Entra roleDefinition object identified by ID. You can't update built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## Examples

### Example 1: Update an roleDefinition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $params = @{
    Id = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    DisplayName = 'UpdatedDisplayName'
 }
 Set-EntraBetaRoleDefinition @params
```

This example updates the specified role definition in Microsoft Entra ID.

- `-Id` parameter specifies the roleDefinition object ID.
- `-DisplayName` parameter specifies the display name for the role definition.

### Example 2: Update an roleDefinition with Description

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $params = @{
    Id = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    Description = 'MYROLEUPDATE1S'
 }
 Set-EntraBetaRoleDefinition @params
```

This example updates the Description of specified role definition in Microsoft Entra ID.

- `-Id` parameter specifies the roleDefinition object ID.
- `-Description` parameter specifies the description for the role definition.

### Example 3: Update an roleDefinition with IsEnabled

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $params = @{
    Id = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    IsEnabled = $true
 }
 Set-EntraBetaRoleDefinition @params
```

This example updates the IsEnabled of specified role definition in Microsoft Entra ID.

- `-Id` parameter specifies the roleDefinition object ID.
- `-IsEnabled` parameter specifies whether the role definition is enabled.

### Example 4: Update an roleDefinition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions = @("microsoft.directory/applications/standard/read")
 $params = @{
    Id = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    Description = 'Update'
    DisplayName = 'Update'
    ResourceScopes = '/'
    IsEnabled = $false
    RolePermissions = $RolePermissions
    TemplateId = '54d418b2-4cc0-47ee-9b39-e8f84ed8e073'
    Version = 2
 }

 Set-EntraBetaRoleDefinition @params
```

This example updates the RolePermissions, TemplateId, TemplateId, ResourceScopes  of specified role definition in Microsoft Entra ID.

- `-Id` parameter specifies the roleDefinition object ID.
- `-RolePermissions` parameter specifies the permissions for the role definition.
- `-IsEnabled` parameter specifies whether the role definition is enabled.
- `-DisplayName` parameter specifies the display name for the role definition.
- `-Description` parameter specifies the description for the role definition.
- `-ResourceScopes` parameter specifies the resource scopes for the role definition.
- `-TemplateId` parameter specifies the template ID for the role definition.
- `-Version` parameter specifies the version for the role definition.

## Parameters

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

Specifies permissions for the role definition.

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

Specifies the template ID for the role definition.

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

Specifies the template ID for the role definition.

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

## Related Links

[New-EntraBetaRoleDefinition](New-EntraBetaRoleDefinition.md)

[Remove-EntraBetaRoleDefinition](Remove-EntraBetaRoleDefinition.md)

[Get-EntraBetaRoleDefinition](Get-EntraBetaRoleDefinition.md)
