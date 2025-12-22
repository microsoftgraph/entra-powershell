---
author: givinalis
description: This article provides details on the Add-EntraBetaScopeToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaScopeToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaScopeToAgentIdentityBlueprint
---

# Add-EntraBetaScopeToAgentIdentityBlueprint

## SYNOPSIS

Adds an OAuth2 permission scope to the current Agent Identity Blueprint.

## SYNTAX

```powershell
Add-EntraBetaScopeToAgentIdentityBlueprint
 [-AgentBlueprintId <String>]
 [-AdminConsentDescription <String>]
 [-AdminConsentDisplayName <String>]
 [-Value <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaScopeToAgentIdentityBlueprint` cmdlet adds a custom OAuth2 permission scope to the Agent Identity Blueprint, allowing applications to request specific permissions when accessing the agent. Uses the stored AgentBlueprintId from the last New-EntraBetaAgentIdentityBlueprint call.

## EXAMPLES

### Example 1: Add scope with prompts

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraBetaScopeToAgentIdentityBlueprint
```

This example adds an OAuth2 permission scope to the Agent Identity Blueprint. The cmdlet will prompt for scope details.

### Example 2: Add scope with all parameters

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Allow agent access" -AdminConsentDisplayName "Agent Access" -Value "agent_access"
```

This example adds an OAuth2 permission scope with specified parameters to the current Agent Identity Blueprint.

### Example 3: Add scope with specific blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaScopeToAgentIdentityBlueprint -AgentBlueprintId "12345678-1234-1234-1234-123456789012" -AdminConsentDescription "Custom agent permission" -AdminConsentDisplayName "Custom Access" -Value "custom.access"
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

Returns the updated scope configuration.

## NOTES

This cmdlet requires the following Microsoft Graph permission:

- Application.ReadWrite.All

The scope is created with type "User" and is enabled by default.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaRedirectURIToAgentIdentityBlueprint](Add-EntraBetaRedirectURIToAgentIdentityBlueprint.md)
