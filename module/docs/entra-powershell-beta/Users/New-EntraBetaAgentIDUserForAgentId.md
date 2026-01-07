---
author: givinalis
description: This article provides details on the New-EntraBetaAgentIDUserForAgentId command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Users
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/New-EntraBetaAgentIDUserForAgentId
schema: 2.0.0
title: New-EntraBetaAgentIDUserForAgentId
---

# New-EntraBetaAgentIDUserForAgentId

## SYNOPSIS

Creates a new Agent User using an Agent Identity.

## SYNTAX

```powershell
New-EntraBetaAgentIDUserForAgentId
 -DisplayName <String>
 [-UserPrincipalName <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentIDUserForAgentId` cmdlet creates a new Agent User by posting to the Microsoft Graph users endpoint using the current Agent Identity ID as the identity parent. The mailNickname is automatically derived from the userPrincipalName.

## EXAMPLES

### Example 1: Create an Agent User with all parameters

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "My Agent Identity" -SponsorUserIds @("user1@contoso.com")
New-EntraBetaAgentIDUserForAgentId -DisplayName "Agent Identity 26192008" -UserPrincipalName "AgentIdentity26192008@contoso.onmicrosoft.com"
```

This example creates an Agent User with the specified display name and user principal name, using the Agent Identity created in the current session.

### Example 2: Create an Agent User with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
# Assumes Agent Identity Blueprint and Agent Identity are already created
New-EntraBetaAgentIDUserForAgentId -DisplayName "HR Agent User"
```

This example creates an Agent User. The cmdlet will prompt for the user principal name if not provided.

### Example 3: Create multiple Agent Users for the same Agent Identity

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "Finance Blueprint" -SponsorUserIds @("finance-admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Finance Agent" -SponsorUserIds @("finance-user@contoso.com")

# Create first Agent User
New-EntraBetaAgentIDUserForAgentId -DisplayName "Finance Agent User 1" -UserPrincipalName "financeagent1@contoso.onmicrosoft.com"

# Create second Agent User for the same Agent Identity
New-EntraBetaAgentIDUserForAgentId -DisplayName "Finance Agent User 2" -UserPrincipalName "financeagent2@contoso.onmicrosoft.com"
```

This example creates multiple Agent Users associated with the same Agent Identity.

## PARAMETERS

### -DisplayName

The display name for the Agent User.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserPrincipalName

The user principal name (email) for the Agent User (e.g., username@domain.onmicrosoft.com). Must be a valid email address format.

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

Returns the Agent User object with properties including id, displayName, userPrincipalName, mailNickname, and accountEnabled.

## NOTES

Requires an Agent Identity to be created first using New-EntraBetaAgentIDForAgentIdentityBlueprint (uses stored Agent Identity ID). The mailNickname is automatically derived from the userPrincipalName by extracting the part before the @ symbol. The Agent User is created with accountEnabled set to true.

This cmdlet requires the following Microsoft Graph permissions:
- AgentIdentityBlueprint.Create
- AgentIdentityBlueprintPrincipal.Create
- AppRoleAssignment.ReadWrite.All
- AgentIdentityBlueprint.ReadWrite.All
- User.ReadWrite.All

## RELATED LINKS

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)
