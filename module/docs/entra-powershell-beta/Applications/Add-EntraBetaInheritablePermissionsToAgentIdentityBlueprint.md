---
author: givinalis
description: This article provides details on the Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
---

# Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint

## SYNOPSIS

Adds inheritable permissions to Agent Identity Blueprints.

## SYNTAX

```powershell
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
 [-Scopes <String[]>]
 [-ResourceAppId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint` cmdlet configures inheritable Microsoft Graph permissions that can be granted to Agent Identity Blueprints. This allows agents created from the blueprint to inherit specific Microsoft Graph permissions.

## EXAMPLES

### Example 1: Add inheritable permissions with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
```

This example prompts for scopes and adds inheritable permissions to the current Agent Identity Blueprint.

### Example 2: Add specific inheritable permissions

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("User.Read", "Mail.Read", "Calendars.Read")
```

This example adds User.Read, Mail.Read, and Calendars.Read as inheritable permissions to the Agent Identity Blueprint.

### Example 3: Add inheritable permissions for a custom resource

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("CustomScope.Read") -ResourceAppId "12345678-1234-1234-1234-123456789012"
```

This example adds inheritable permissions for a custom resource application by specifying the ResourceAppId.

## PARAMETERS

### -Scopes

Array of Microsoft Graph permission scopes to make inheritable. Common scopes include: User.Read, Mail.Read, Calendars.Read, etc. If not provided, will prompt for input.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceAppId

The resource application ID as a GUID. Defaults to Microsoft Graph (00000003-0000-0000-c000-000000000000).
This parameter accepts either a GUID object or a string that can be converted to a GUID.

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

Returns the result of the inheritable permissions configuration.

## NOTES

This cmdlet requires the following Microsoft Graph permission:

- Application.ReadWrite.All

This cmdlet requires an Agent Identity Blueprint to be created first. It uses the stored blueprint ID from the last blueprint creation.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal.md)
