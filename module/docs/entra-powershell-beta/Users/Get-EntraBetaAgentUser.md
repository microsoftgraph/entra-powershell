---
author: givinalis
description: This article provides details on the Get-EntraBetaAgentUser command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Users
ms.author: giomachar
ms.date: 04/25/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Get-EntraBetaAgentUser
schema: 2.0.0
title: Get-EntraBetaAgentUser
---

# Get-EntraBetaAgentUser

## SYNOPSIS

Gets an Agent User by its ID, or lists all Agent Users connected to an Agent Identity.

## SYNTAX

### GetById (Default)

```powershell
Get-EntraBetaAgentUser
 [-AgentUserId <String>]
 [<CommonParameters>]
```

### GetByAgentId

```powershell
Get-EntraBetaAgentUser
 -AgentId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAgentUser` cmdlet retrieves Agent Users from Microsoft Graph. When used with `-AgentUserId`, it returns a single agent user. When used with `-AgentId`, it returns all agent users connected to the specified Agent Identity. If no agent user ID is provided in the GetById parameter set, it uses the stored agent user ID from the current session or prompts for one.

## EXAMPLES

### Example 1: Get an Agent User by ID

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaAgentUser -AgentUserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

This example retrieves the Agent User with the specified ID.

### Example 2: Get the Agent User from the current session

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
New-EntraBetaAgentUserForAgentId -DisplayName "My Agent User" -UserPrincipalName "myagent@contoso.onmicrosoft.com"
$agentUser = Get-EntraBetaAgentUser
Write-Host "Agent User: $($agentUser.displayName)"
```

This example retrieves the Agent User that was created in the current session using the stored agent user ID.

### Example 3: List all Agent Users for an Agent Identity

```powershell
Connect-Entra -Scopes 'User.Read.All'
$agentUsers = Get-EntraBetaAgentUser -AgentId "cccccccc-3333-4444-5555-dddddddddddd"
$agentUsers | ForEach-Object { Write-Host "$($_.displayName) ($($_.userPrincipalName))" }
```

This example retrieves all Agent Users that are connected to the specified Agent Identity.

### Example 4: Get an Agent User with error handling

```powershell
Connect-Entra -Scopes 'User.Read.All'
try {
    $agentUser = Get-EntraBetaAgentUser -AgentUserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    Write-Host "Agent User found: $($agentUser.displayName) ($($agentUser.userPrincipalName))"
} catch {
    Write-Host "Agent User not found or error occurred: $_"
}
```

This example demonstrates how to retrieve an Agent User with error handling to catch cases where the user doesn't exist.

## PARAMETERS

### -AgentUserId

The ID of the Agent User to retrieve. If not provided, uses the stored agent user ID from the current session or prompts for one. Used with the GetById parameter set.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentId

The ID of the Agent Identity to retrieve connected Agent Users for. Returns all agent users that are connected to the specified agent identity. Used with the GetByAgentId parameter set.

```yaml
Type: System.String
Parameter Sets: GetByAgentId
Aliases:

Required: True
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

When using `-AgentUserId`, returns a single Agent User object. When using `-AgentId`, returns an array of Agent User objects. Each object includes properties such as id, displayName, userPrincipalName, mailNickname, accountEnabled, and identityParentId.

## NOTES

If the Agent User or Agent Identity with the specified ID is not found, the cmdlet will throw an error. When listing by Agent Identity, supports pagination to retrieve all results.

This cmdlet requires the following Microsoft Graph permissions:
- User.Read.All

## RELATED LINKS

[New-EntraBetaAgentUserForAgentId](New-EntraBetaAgentUserForAgentId.md)

[Get-EntraBetaAgentIdentity](../Applications/Get-EntraBetaAgentIdentity.md)

[Get-EntraBetaAgentIdentityBlueprint](../Applications/Get-EntraBetaAgentIdentityBlueprint.md)
