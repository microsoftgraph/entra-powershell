---
author: givinalis
description: This article provides details on the Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
---

# Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal

## SYNOPSIS

Grants permission to create Agent Users to the Agent Identity Blueprint Principal.

## SYNTAX

```powershell
Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal` cmdlet adds the AgentIdUser.ReadWrite.IdentityParentedBy permission to the Agent Identity Blueprint Service Principal. This permission allows the blueprint to create agent users that are parented to agent identities. The cmdlet looks up the blueprint's service principal and the Microsoft Graph service principal in the tenant, then creates an app role assignment linking them. Uses the stored AgentBlueprintId from the last `New-EntraBetaAgentIdentityBlueprint` call if no explicit ID is provided.

## EXAMPLES

### Example 1: Grant permission using stored blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.IdentityParentedBy'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
New-EntraBetaAgentIdentityBlueprintPrincipal
Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
```

This example grants the AgentIdUser.ReadWrite.IdentityParentedBy permission to the Agent Identity Blueprint Service Principal that was just created.

### Example 2: Grant permission using specific blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.IdentityParentedBy'
Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -AgentBlueprintId "7c0c1226-1e81-41a5-ad6c-532c95504443"
```

This example grants the permission to a specific Agent Identity Blueprint by providing the blueprint ID.

## PARAMETERS

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to grant permissions to. If not provided, uses the stored ID from the last blueprint creation.

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

Returns the app role assignment response object from Microsoft Graph, enriched with the following additional properties:

- **AgentBlueprintId** - The Application ID of the Agent Identity Blueprint.
- **AgentBlueprintServicePrincipalId** - The object ID of the blueprint's service principal.
- **PermissionName** - The permission name (`AgentIdUser.ReadWrite.IdentityParentedBy`).
- **PermissionDescription** - A description of what the permission allows.
- **MSGraphServicePrincipalId** - The object ID of the Microsoft Graph service principal in the tenant.

The base response includes `id`, `principalId`, `resourceId`, and `appRoleId`.

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- AgentIdentityBlueprint.UpdateAuthProperties.All
- AgentIdUser.ReadWrite.IdentityParentedBy

This cmdlet requires the Agent Identity Blueprint Service Principal to be created first using `New-EntraBetaAgentIdentityBlueprintPrincipal`. The cmdlet looks up the blueprint's service principal by filtering on `appId`, so the blueprint must already have a service principal in the tenant.

The Microsoft Graph Service Principal ID is cached after the first lookup for performance. The cmdlet also stores the blueprint service principal ID in a module-level variable (`CurrentAgentBlueprintServicePrincipalId`) for use by other cmdlets.

The specific app role assigned is `AgentIdUser.ReadWrite.IdentityParentedBy` (ID: `4aa6e624-eee0-40ab-bdd8-f9639038a614`).

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)
