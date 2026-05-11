---
author: givinalis
description: This article provides details on the New-EntraAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/New-EntraAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: New-EntraAgentIdentityBlueprintPrincipal
---

# New-EntraAgentIdentityBlueprintPrincipal

## SYNOPSIS

Creates a service principal for the Agent Identity Blueprint.

## SYNTAX

```powershell
New-EntraAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraAgentIdentityBlueprintPrincipal` cmdlet creates a service principal for the current Agent Identity Blueprint using the specialized graph.agentIdentityBlueprintPrincipal endpoint. Uses the stored AgentBlueprintId from the last New-EntraAgentIdentityBlueprint call. If no stored ID is available and the parameter is not provided, the cmdlet prompts interactively for the blueprint Application ID.

## EXAMPLES

### Example 1: Create service principal using stored blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentityBlueprint.UpdateAuthProperties.All'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
New-EntraAgentIdentityBlueprintPrincipal
```

```Output
Name                           Value
----                           -----
id                             sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb
appId                          bbbbbbbb-2222-3333-4444-cccccccccccc
displayName                    My Blueprint
servicePrincipalType           Application
```

This example creates a service principal for the Agent Identity Blueprint that was just created. The cmdlet uses the stored blueprint ID from the last blueprint creation.

### Example 2: Create service principal with specific blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentityBlueprint.UpdateAuthProperties.All'
New-EntraAgentIdentityBlueprintPrincipal -AgentBlueprintId "021fe0d0-d128-4769-950c-fcfbf7b87def"
```

```Output
Name                           Value
----                           -----
id                             sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb
appId                          021fe0d0-d128-4769-950c-fcfbf7b87def
displayName                    My Blueprint
servicePrincipalType           Application
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

This cmdlet requires an Agent Identity Blueprint to be created first. If no AgentBlueprintId parameter is provided and no stored ID is available from a previous `New-EntraAgentIdentityBlueprint` call, the cmdlet prompts interactively for the blueprint Application ID. The cmdlet stores the created service principal ID in a module-level variable (`CurrentAgentBlueprintServicePrincipalId`) for use by other related cmdlets such as consent and permission configuration cmdlets.

The cmdlet includes retry logic (up to 10 attempts with 10-second waits) to handle propagation delays after blueprint creation.

This cmdlet uses the Microsoft Graph v1.0 API endpoint (`/v1.0/servicePrincipals/graph.agentIdentityBlueprintPrincipal`).

This cmdlet requires the following Microsoft Graph permissions:
- AgentIdentityBlueprintPrincipal.Create

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](../../../entra-powershell-beta/Applications/New-EntraBetaAgentIdentityBlueprintPrincipal.md)
