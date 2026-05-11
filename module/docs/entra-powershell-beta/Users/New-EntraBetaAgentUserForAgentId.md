---
author: givinalis
description: This article provides details on the New-EntraBetaAgentUserForAgentId command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Users
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/New-EntraBetaAgentUserForAgentId
schema: 2.0.0
title: New-EntraBetaAgentUserForAgentId
---

# New-EntraBetaAgentUserForAgentId

## SYNOPSIS

Creates a new Agent User using an Agent Identity.

## SYNTAX

```powershell
New-EntraBetaAgentUserForAgentId
 -DisplayName <String>
 [-UserPrincipalName <String>]
 [-MailNickname <String>]
 [-AgentIdentityId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentUserForAgentId` cmdlet creates a new Agent User by posting to the Microsoft Graph users endpoint using an Agent Identity ID as the identity parent. The mailNickname is derived from the UserPrincipalName prefix by default but can be overridden with the `-MailNickname` parameter or interactively. If `-UserPrincipalName` is not provided, the cmdlet looks up the tenant's default domain and prompts interactively with a suggested UPN.

## EXAMPLES

### Example 1: Create an Agent User with all parameters

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "My Agent Identity" -SponsorUserIds @("user1@contoso.com")
New-EntraBetaAgentUserForAgentId -DisplayName "Agent Identity 26192008" -UserPrincipalName "AgentIdentity26192008@contoso.onmicrosoft.com"
```

This example creates an Agent User with the specified display name and user principal name, using the Agent Identity created in the current session.

### Example 2: Create an Agent User with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
# Assumes Agent Identity Blueprint and Agent Identity are already created
New-EntraBetaAgentUserForAgentId -DisplayName "HR Agent User"
```

This example creates an Agent User. The cmdlet will prompt for the user principal name if not provided.

### Example 3: Create multiple Agent Users for the same Agent Identity

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "Finance Blueprint" -SponsorUserIds @("finance-admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Finance Agent" -SponsorUserIds @("finance-user@contoso.com")

# Create first Agent User
New-EntraBetaAgentUserForAgentId -DisplayName "Finance Agent User 1" -UserPrincipalName "financeagent1@contoso.onmicrosoft.com"

# Create second Agent User for the same Agent Identity
New-EntraBetaAgentUserForAgentId -DisplayName "Finance Agent User 2" -UserPrincipalName "financeagent2@contoso.onmicrosoft.com"
```

This example creates multiple Agent Users associated with the same Agent Identity.

### Example 4: Create an Agent User with explicit Agent Identity ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
$agentIdentity = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "My Agent Identity"
New-EntraBetaAgentUserForAgentId -DisplayName "Agent User" -UserPrincipalName "agentuser@contoso.onmicrosoft.com" -AgentIdentityId $agentIdentity.id
```

This example creates an Agent User by explicitly providing the Agent Identity ID, which is useful when calling from different module scopes or scripts.

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

The user principal name (email) for the Agent User (e.g., username@domain.onmicrosoft.com). Must be a valid email address format. If not provided, the cmdlet looks up the tenant's default domain and prompts interactively with a suggested UPN derived from the display name.

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

### -MailNickname

The mail nickname (alias) for the Agent User. If not provided, it is derived from the UserPrincipalName prefix (the part before the @ symbol) and the user is prompted to confirm or override it.

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

### -AgentIdentityId

The Agent Identity ID to associate with this user. If not provided, the cmdlet uses the stored value from New-EntraBetaAgentIDForAgentIdentityBlueprint. Use this parameter when calling from different module scopes or when you want to explicitly specify the Agent Identity.

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

Returns the Agent User object from the Microsoft Graph API response with the following properties:

- **@odata.type** — `microsoft.graph.agentUser`
- **id** — The unique identifier of the created Agent User.
- **displayName** — The display name of the Agent User.
- **userPrincipalName** — The user principal name of the Agent User.
- **mailNickname** — The mail nickname (alias) of the Agent User.
- **accountEnabled** — Whether the account is enabled (always `true`).
- **identityParentId** — The ID of the parent Agent Identity.

Additional properties from the Graph API response may also be included.

## NOTES

This cmdlet requires the following Microsoft Graph permission:

- `AgentIdUser.ReadWrite.All`

The Agent Identity ID can be provided via the `-AgentIdentityId` parameter or is automatically retrieved from the global variable `$global:EntraBetaCurrentAgentIdentityId` set by `New-EntraBetaAgentIDForAgentIdentityBlueprint`. The global variable is used because this cmdlet is in a different module (`Microsoft.Entra.Beta.Users`) than the blueprint cmdlets (`Microsoft.Entra.Beta.Applications`).

The cmdlet stores the created Agent User ID in `$script:CurrentAgentUserId` for use by subsequent cmdlets.

The cmdlet includes retry logic (up to 10 attempts with 10-second waits) to handle propagation delays.

When `-UserPrincipalName` is not provided, the cmdlet:

- Queries the tenant's default domain via the organization API
- Suggests a UPN by concatenating the display name words as a prefix with the tenant domain
- Validates the UPN against a regex pattern and re-prompts if invalid

The `-UserPrincipalName` parameter validates input against the pattern `^[#a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`.

## RELATED LINKS

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)
