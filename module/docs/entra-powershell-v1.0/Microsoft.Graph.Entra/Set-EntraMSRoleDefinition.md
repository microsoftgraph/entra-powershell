---
title: Set-EntraMSRoleDefinition.
description: This article provides details on the Set-EntraMSRoleDefinition command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSRoleDefinition

## SYNOPSIS
Update an existing Microsoft Entra ID roleDefinition.

## SYNTAX

```powershell
Set-EntraMSRoleDefinition 
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

## DESCRIPTION
Updates a Microsoft Entra ID roleDefinition object identified by ID.

## EXAMPLES

### Example 1: Update an roleDefinition.

```powershell
PS C:\> Set-EntraMSRoleDefinition -ID c466024e-f789-4409-a897-d220916814b1 -DisplayName 'UpdatedDisplayName'
```

This example updates the specified role definition in Microsoft Entra ID.

### Example 2: Update an roleDefinition with Description.

```powershell
PS C:\> Set-EntraMSRoleDefinition -Id 4dd5aa9c-cf4d-4895-a993-740d342802b9 -Description "MYROLEUPDATE1S"
```

This example updates the Description of specified role definition in Microsoft Entra ID.

### Example 3: Update an roleDefinition with IsEnabled.

```powershell
PS C:\> Set-EntraMSRoleDefinition -Id 4dd5aa9c-cf4d-4895-a993-740d342802b9 -IsEnabled $true
```

This example updates the IsEnabled of specified role definition in Microsoft Entra ID.

### Example 4: Update an roleDefinition.

```powershell
PS C:\> $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
PS C:\> $RolePermissions.AllowedResourceActions = @("microsoft.directory/applications/standard/read")
PS C:\> Set-EntraMSRoleDefinition -Id 54d418b2-4cc0-47ee-9b39-e8f84ed8e073 -Description "Update" -DisplayName "Update" -ResourceScopes "/" -IsEnabled $false -RolePermissions $RolePermissions -TemplateId 54d418b2-4cc0-47ee-9b39-e8f84ed8e073 -TemplateId  2
```

This example updates the RolePermissions, TemplateId, TemplateId, ResourceScopes  of specified role definition in Microsoft Entra ID.


## PARAMETERS

### -Id
The unique identifier of an object in Microsoft Entra ID

```yaml
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsEnabled
Specifies whether the role definition is enabled.

```yaml
Type: Boolean
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
Specifies template ID for the role definition.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSRoleDefinition](Get-EntraMSRoleDefinition.md)

[New-EntraMSRoleDefinition](New-EntraMSRoleDefinition.md)


