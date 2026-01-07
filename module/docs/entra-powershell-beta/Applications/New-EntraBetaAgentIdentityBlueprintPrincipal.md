---
author: givinalis
description: This article provides details on the New-EntraBetaAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/New-EntraBetaAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: New-EntraBetaAgentIdentityBlueprintPrincipal
---

# New-EntraBetaAgentIdentityBlueprintPrincipal

## SYNOPSIS

Creates a service principal for the Agent Identity Blueprint.

## SYNTAX

```powershell
New-EntraBetaAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentIdentityBlueprintPrincipal` cmdlet creates a service principal for the current Agent Identity Blueprint using the specialized graph.agentIdentityBlueprintPrincipal endpoint. Uses the stored AgentBlueprintId from the last New-EntraBetaAgentIdentityBlueprint call.

## EXAMPLES

### Example 1: Create service principal using stored blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
New-EntraBetaAgentIdentityBlueprintPrincipal
```

This example creates a service principal for the Agent Identity Blueprint that was just created. The cmdlet uses the stored blueprint ID from the last blueprint creation.

### Example 2: Create service principal with specific blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprintPrincipal -AgentBlueprintId "021fe0d0-d128-4769-950c-fcfbf7b87def"
```

This example creates a service principal for a specific Agent Identity Blueprint by providing the blueprint ID.

## PARAMETERS

### -AgentBlueprintId

The Application ID (AppId) of the Agent Identity Blueprint to create the service principal for. If not provided, uses the stored ID from the last blueprint creation.

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

### None

## OUTPUTS

### System.Object

Returns the service principal response object from Microsoft Graph with properties including id, appId, and displayName.

## NOTES

This cmdlet requires an Agent Identity Blueprint to be created first. The cmdlet stores the service principal ID in a module-level variable for use by other related cmdlets.

This cmdlet requires the following Microsoft Graph permissions:
- AgentIdentityBlueprintPrincipal.Create
- Application.ReadWrite.All

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal.md)

[Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal.md)
