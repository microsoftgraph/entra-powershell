---
Title: New-EntraRoleDefinition
Description: This article provides details on the New-EntraRoleDefinition command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# New-EntraRoleDefinition

## Synopsis

Create a new Microsoft Entra ID roleDefinition.

## Syntax

```powershell
New-EntraRoleDefinition 
 [-TemplateId <String>] 
 -DisplayName <String>
 -RolePermissions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]>
 [-Description <String>] 
 [-Version <String>] 
 -IsEnabled <Boolean>
 [-ResourceScopes <System.Collections.Generic.List`1[System.String]>] 
 [<CommonParameters>]
```

## Description

Create a new Microsoft Entra ID `roleDefinition` object.

## Examples

### Example 1: Creates a new role definition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")

 $params = @{
    RolePermissions = $RolePermissions
    IsEnabled = $false
    DisplayName = 'MyRoleDefinition'
 }

 New-EntraMSRoleDefinition @params
```

```Output

DisplayName      Id                                   TemplateId                           Description IsBuiltIn IsEnabled
-----------      --                                   ----------                           ----------- --------- ---------
MyRoleDefinition a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 93ff7659-04bd-4d97-8add-b6c992cce98e             False     False

```

This command creates a new role definition in Microsoft Entra ID.

### Example 2: Creates a new role definition with Description parameter

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
 $params = @{
    RolePermissions = $RolePermissions
    IsEnabled = $false
    DisplayName = 'MyRoleDefinition'
    Description = 'Role Definition demo'
 }

 New-EntraMSRoleDefinition @params
```

```Output

DisplayName      Id                                   TemplateId                           Description          IsBuiltIn IsEnabled
-----------      --                                   ----------                           -----------          --------- ---------
MyRoleDefinition a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 e14cb8e2-d696-4756-bd7f-c7df25271f3d Role Definition demo False     False

```

This command creates a new role definition with Description parameter.

### Example 3: Creates a new role definition with ResourceScopes parameter

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
 $params = @{
    RolePermissions = $RolePermissions
    IsEnabled = $false
    DisplayName = 'MyRoleDefinition'
    ResourceScopes = '/'
 }

 New-EntraMSRoleDefinition @params
```

```Output
DisplayName      Id                                   TemplateId                           Description IsBuiltIn IsEnabled
-----------      --                                   ----------                           ----------- --------- ---------
MyRoleDefinition a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 2bc29892-ca2e-457e-b7c0-03257a0bcd0c             False     False

```

This command creates a new role definition with ResourceScopes parameter.

### Example 4: Creates a new role definition with TemplateId parameter

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
 $params = @{
    RolePermissions = $RolePermissions
    IsEnabled = $false
    DisplayName = 'MyRoleDefinition'
    TemplateId = '4dd5aa9c-cf4d-4895-a993-740d342802b9'
 }

 New-EntraMSRoleDefinition @params
```

```Output
DisplayName      Id                                   TemplateId                           Description IsBuiltIn IsEnabled
-----------      --                                   ----------                           ----------- --------- ---------
MyRoleDefinition a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 4dd5aa9c-cf4d-4895-a993-740d342802b9             False     False

```

This command creates a new role definition with TemplateId parameter.

### Example 5: Creates a new role definition with Version parameter

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
 $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
 $params = @{
    RolePermissions = $RolePermissions
    IsEnabled = $false
    DisplayName = 'MyRoleDefinition'
    Version = '2'
 }

 New-EntraMSRoleDefinition @params
```

```Output
DisplayName      Id                                   TemplateId                           Description IsBuiltIn IsEnabled
-----------      --                                   ----------                           ----------- --------- ---------
MyRoleDefinition a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 b69d16e9-b3f9-4289-a87f-8f796bd9fa28             False     False

```

This command creates a new role definition with Version parameter.

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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsEnabled

Specifies whether the role definition is enabled.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
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

Required: True
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

Specifies version for the role definition.

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

## Outputs

### Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition

## Notes

## Related Links

[Get-EntraMSRoleDefinition](Get-EntraMSRoleDefinition.md)

[Remove-EntraRoleDefinition](Remove-EntraRoleDefinition.md)

[Set-EntraRoleDefinition](Set-EntraRoleDefinition.md)
