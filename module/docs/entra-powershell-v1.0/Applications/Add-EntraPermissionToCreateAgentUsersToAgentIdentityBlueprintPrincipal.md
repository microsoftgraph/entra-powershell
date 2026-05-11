---
author: givinalis
description: This article provides details on the Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
---

# Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal

## SYNOPSIS

Grants permission to create Agent Users to the Agent Identity Blueprint Principal.

## SYNTAX

```powershell
Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal` cmdlet adds the AgentIdUser.ReadWrite.IdentityParentedBy permission to the Agent Identity Blueprint Service Principal. This permission allows the blueprint to create agent users that are parented to agent identities. The cmdlet looks up the blueprint's service principal and the Microsoft Graph service principal in the tenant, then creates an app role assignment linking them. Uses the stored AgentBlueprintId from the last `New-EntraAgentIdentityBlueprint` call if no explicit ID is provided. If no stored ID is available, the cmdlet prompts interactively for the blueprint Application ID.

## EXAMPLES

### Example 1: Grant permission using stored blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.IdentityParentedBy'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
New-EntraAgentIdentityBlueprintPrincipal
Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
```

```Output
Name                                Value
----                                -----
id                                  assignment-guid
principalId                         sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb
resourceId                          graph-sp-id
appRoleId                           4aa6e624-eee0-40ab-bdd8-f9639038a614
AgentBlueprintId                    bbbbbbbb-2222-3333-4444-cccccccccccc
AgentBlueprintServicePrincipalId    sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb
PermissionName                      AgentIdUser.ReadWrite.IdentityParentedBy
PermissionDescription               Allows creation of agent users parented to agent identities
MSGraphServicePrincipalId           graph-sp-id
```

This example grants the AgentIdUser.ReadWrite.IdentityParentedBy permission to the Agent Identity Blueprint Service Principal that was just created.

### Example 2: Grant permission using specific blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.IdentityParentedBy'
Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -AgentBlueprintId "7c0c1226-1e81-41a5-ad6c-532c95504443"
```

This example grants the permission to a specific Agent Identity Blueprint by providing the blueprint ID.

## PARAMETERS

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to grant permissions to. If not provided, uses the stored ID from the last blueprint creation, or prompts interactively.

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

This cmdlet requires the Agent Identity Blueprint Service Principal to be created first using `New-EntraAgentIdentityBlueprintPrincipal`. The cmdlet looks up the blueprint's service principal by filtering on `appId`, so the blueprint must already have a service principal in the tenant.

The Microsoft Graph Service Principal ID is cached after the first lookup for performance. The cmdlet also stores the blueprint service principal ID in a module-level variable (`CurrentAgentBlueprintServicePrincipalId`) for use by other cmdlets.

This cmdlet uses the Microsoft Graph v1.0 API endpoint (`/v1.0/servicePrincipals`).

The specific app role assigned is `AgentIdUser.ReadWrite.IdentityParentedBy` (ID: `4aa6e624-eee0-40ab-bdd8-f9639038a614`).

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[New-EntraAgentIdentityBlueprintPrincipal](New-EntraAgentIdentityBlueprintPrincipal.md)

[Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal](../../../entra-powershell-beta/Applications/Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal.md)
