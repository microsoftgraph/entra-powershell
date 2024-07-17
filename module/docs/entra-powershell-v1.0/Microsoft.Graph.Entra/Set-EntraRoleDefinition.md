---
title: Set-EntraRoleDefinition.
description: This article provides details on the Set-EntraRoleDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraRoleDefinition

## Synopsis

Update an existing Microsoft Entra ID roleDefinition.

## Syntax

```powershell
Set-EntraRoleDefinition 
[-TemplateId <String>] 
[-DisplayName <String>]
[-RolePermissions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]>]
-Id <String> 
[-Description <String>] 
[-Version <String>] 
[-IsEnabled <Boolean>]
[-ResourceScopes <System.Collections.Generic.List`1[System.String]>] 
[<CommonParameters>]
```

## Description

Updates a Microsoft Entra roleDefinition object identified by ID. You cannot update built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## Examples

### Example 1: Update an roleDefinition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 Set-EntraRoleDefinition -ID a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 -DisplayName 'UpdatedDisplayName'
```

This example updates the specified role definition in Microsoft Entra ID.

### Example 2: Update an roleDefinition with Description

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 Set-EntraRoleDefinition -Id a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 -Description 'MYROLEUPDATE1S'
```

This example updates the Description of specified role definition in Microsoft Entra ID.

### Example 3: Update an roleDefinition with IsEnabled

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 Set-EntraRoleDefinition -Id a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 -IsEnabled $true
```

This example updates the IsEnabled of specified role definition in Microsoft Entra ID.

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

 Set-EntraRoleDefinition @params
```

This example updates the RolePermissions, TemplateId, TemplateId, ResourceScopes  of specified role definition in Microsoft Entra ID.

## Parameters

### -Id

The unique identifier of an object in Microsoft Entra ID

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

Specifies template ID for the role definition. Custom template identifier that can be set when `isBuiltIn1 is 1false`. This identifier is typically used if one needs an identifier to be the same across different directories. Read-only when `isBuiltIn` is `true`.

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

### String

## Outputs

## Notes

## Related Links

[Get-EntraRoleDefinition](Get-EntraRoleDefinition.md)

[New-EntraRoleDefinition](New-EntraRoleDefinition.md)
