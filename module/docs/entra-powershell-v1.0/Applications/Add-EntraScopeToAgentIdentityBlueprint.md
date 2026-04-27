---
author: givinalis
description: This article provides details on the Add-EntraScopeToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Add-EntraScopeToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraScopeToAgentIdentityBlueprint
---

# Add-EntraScopeToAgentIdentityBlueprint

## SYNOPSIS

Adds an OAuth2 permission scope to the current Agent Identity Blueprint.

## SYNTAX

```powershell
Add-EntraScopeToAgentIdentityBlueprint
 [-AgentBlueprintId <String>]
 [-AdminConsentDescription <String>]
 [-AdminConsentDisplayName <String>]
 [-Value <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraScopeToAgentIdentityBlueprint` cmdlet adds a custom OAuth2 permission scope to an Agent Identity Blueprint. The cmdlet first retrieves the existing scopes from the blueprint, checks for duplicates by value, and merges the new scope with any existing scopes before updating. If a scope with the same value already exists, it is returned without modification. If no blueprint ID is provided, it uses the stored ID from the most recent `New-EntraAgentIdentityBlueprint` call. If scope parameters are not provided, the cmdlet prompts interactively with sensible defaults.

## EXAMPLES

### Example 1: Add scope with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraScopeToAgentIdentityBlueprint
```

This example adds an OAuth2 permission scope to the Agent Identity Blueprint. The cmdlet will prompt for scope details.

### Example 2: Add scope with all parameters

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraScopeToAgentIdentityBlueprint -AdminConsentDescription "Allow agent access" -AdminConsentDisplayName "Agent Access" -Value "agent_access"
```

This example adds an OAuth2 permission scope with specified parameters to the current Agent Identity Blueprint.

### Example 3: Add scope with specific blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraScopeToAgentIdentityBlueprint -AgentBlueprintId "12345678-1234-1234-1234-123456789012" -AdminConsentDescription "Custom agent permission" -AdminConsentDisplayName "Custom Access" -Value "custom.access"
```

This example adds an OAuth2 permission scope to a specific Agent Identity Blueprint by providing the blueprint ID.

## PARAMETERS

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to add the scope to. If not provided, uses the stored ID from the last blueprint creation.

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

### -AdminConsentDescription

The description that appears in admin consent experiences. If not provided, will prompt for input. Default: "Allow the agent to act on behalf of the signed-in user".

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

### -AdminConsentDisplayName

The display name that appears in admin consent experiences. If not provided, will prompt for input. Default: "Access agent on behalf of user".

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

### -Value

The value of the permission scope (used in token claims). If not provided, will prompt for input. Default: "access_agent_as_user".

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

Returns a PSCustomObject with the following properties: ScopeId, AdminConsentDescription, AdminConsentDisplayName, Value, IdentifierUri, AgentBlueprintId, and FullScopeReference (e.g., `api://{id}/{value}`).

## NOTES

This cmdlet uses the Microsoft Graph v1.0 API endpoint (`/v1.0/applications/{id}`).

This cmdlet requires the following Microsoft Graph permission:

- AgentIdentityBlueprint.UpdateAuthProperties.All

The scope is created with type "User" and is enabled by default. The cmdlet merges new scopes with any existing scopes on the blueprint rather than overwriting them. If a scope with the same `Value` already exists, it is returned without making any changes. The cmdlet includes retry logic (up to 10 attempts with 10-second intervals) to handle propagation delays.

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[Add-EntraBetaScopeToAgentIdentityBlueprint](../../../entra-powershell-beta/Applications/Add-EntraBetaScopeToAgentIdentityBlueprint.md)
