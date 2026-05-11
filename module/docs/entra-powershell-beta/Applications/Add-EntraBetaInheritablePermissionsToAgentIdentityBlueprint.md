---
author: givinalis
description: This article provides details on the Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 04/25/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
---

# Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint

## SYNOPSIS

Adds inheritable permissions (scopes, roles, or both) to an Agent Identity Blueprint.

## SYNTAX

```powershell
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
 [-ResourceAppId <Guid>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint` cmdlet configures inheritable permissions on an Agent Identity Blueprint. For each resource, the cmdlet prompts whether to make scopes, roles, or both inheritable using an "all allowed" policy. This allows agents created from the blueprint to inherit the specified permission types. The cmdlet checks for existing inheritable permissions on the blueprint — if an entry for the resource already exists, it overwrites it (PATCH); otherwise, it adds a new entry (POST), preserving other resources' permissions. The cmdlet supports adding permissions for multiple resources in a single invocation.

## EXAMPLES

### Example 1: Add inheritable permissions with default settings

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
```

This example prompts for the permission type (scopes, roles, or both) and adds inheritable permissions to the current Agent Identity Blueprint using Microsoft Graph as the default resource.

### Example 2: Add inheritable permissions for a custom resource

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId "12345678-1234-1234-1234-123456789012"
```

This example adds inheritable permissions for a custom resource application. The cmdlet prompts whether to make scopes, roles, or both inheritable.

### Example 3: Add inheritable permissions for multiple resources

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
```

When prompted, choose the permission type for the first resource (Microsoft Graph), then answer "y" to add another resource and repeat for each additional resource application.

## PARAMETERS

### -ResourceAppId

The resource application ID as a GUID. Defaults to Microsoft Graph (00000003-0000-0000-c000-000000000000). This parameter accepts either a GUID object or a string that can be converted to a GUID.

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

### System.Object

Returns an array of results, each containing AgentBlueprintId, ResourceAppId, ResourceAppName, InheritableScopes (allAllowed or none), InheritableRoles (allAllowed or none), ConfiguredAt, and ApiResponse.

## NOTES

The cmdlet interactively prompts for each resource whether to make scopes, roles, or both inheritable. It uses an "all allowed" policy for the selected permission types.

This cmdlet requires the following Microsoft Graph permission:
- AgentIdentityBlueprint.UpdateAuthProperties.All

This cmdlet requires an Agent Identity Blueprint to be created first. It uses the stored blueprint ID from the last blueprint creation.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal.md)
