---
author: givinalis
description: This article provides details on the Add-EntraInheritablePermissionsToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Add-EntraInheritablePermissionsToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraInheritablePermissionsToAgentIdentityBlueprint
---

# Add-EntraInheritablePermissionsToAgentIdentityBlueprint

## SYNOPSIS

Adds inheritable permissions (scopes, roles, or both) to the current Agent Identity Blueprint for a specified resource application.

## SYNTAX

```powershell
Add-EntraInheritablePermissionsToAgentIdentityBlueprint
 [-ResourceAppId <Guid>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraInheritablePermissionsToAgentIdentityBlueprint` cmdlet adds inheritable permissions to an Agent Identity Blueprint. It allows you to configure which OAuth2 permission scopes and/or application roles from a resource application (such as Microsoft Graph) can be inherited by agent blueprints.

The cmdlet interactively prompts for the permission type (scopes, roles, or both) and supports adding permissions for multiple resource applications in a single session.

This cmdlet uses the Microsoft Graph v1.0 API endpoint `/v1.0/applications/microsoft.graph.agentIdentityBlueprint/{id}/inheritablePermissions`.

## EXAMPLES

### Example 1: Add inheritable permissions for Microsoft Graph (default)

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraInheritablePermissionsToAgentIdentityBlueprint
```

This example adds inheritable permissions for the default Microsoft Graph resource application. The cmdlet prompts interactively for whether to make scopes, roles, or both inheritable.

### Example 2: Add inheritable permissions for a custom resource application

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId "aaaabbbb-cccc-dddd-eeee-ffffffffffff"
```

This example adds inheritable permissions for a custom resource application specified by its GUID.

## PARAMETERS

### -ResourceAppId

The resource application ID (GUID) for which to add inheritable permissions. Defaults to Microsoft Graph (`00000003-0000-0000-c000-000000000000`).

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 00000003-0000-0000-c000-000000000000
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.PSCustomObject

Returns an object with the following properties:

AgentBlueprintId: The ID of the Agent Identity Blueprint.
ResourceAppId: The resource application ID.
ResourceAppName: The display name of the resource application.
InheritableScopes: Whether scopes are inheritable (allAllowed or none).
InheritableRoles: Whether roles are inheritable (allAllowed or none).
ConfiguredAt: The timestamp when the permissions were configured.
ApiResponse: The raw API response.

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[Add-EntraScopeToAgentIdentityBlueprint](Add-EntraScopeToAgentIdentityBlueprint.md)
