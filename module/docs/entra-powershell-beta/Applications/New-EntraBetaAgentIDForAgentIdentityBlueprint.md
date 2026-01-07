---
author: givinalis
description: This article provides details on the New-EntraBetaAgentIDForAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/New-EntraBetaAgentIDForAgentIdentityBlueprint
schema: 2.0.0
title: New-EntraBetaAgentIDForAgentIdentityBlueprint
---

# New-EntraBetaAgentIDForAgentIdentityBlueprint

## SYNOPSIS

Creates a new Agent Identity using an Agent Identity Blueprint.

## SYNTAX

```powershell
New-EntraBetaAgentIDForAgentIdentityBlueprint
 -DisplayName <String>
 [-SponsorUserIds <String[]>]
 [-SponsorGroupIds <String[]>]
 [-OwnerUserIds <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentIDForAgentIdentityBlueprint` cmdlet creates a new Agent Identity by posting to the Microsoft Graph AgentIdentity endpoint using the current Agent Identity Blueprint ID and specified sponsors/owners.

## EXAMPLES

### Example 1: Create an agent identity with sponsors and owners

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "My Agent Identity" -SponsorUserIds @("user1@contoso.com") -OwnerUserIds @("owner1@contoso.com")
```

This example creates an Agent Identity with the specified display name, sponsors, and owners using the Agent Identity Blueprint created in the current session.

### Example 2: Create an agent identity with user and group sponsors

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "HR Agent" -SponsorUserIds @("hr-admin@contoso.com") -SponsorGroupIds @("aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb")
```

This example creates an Agent Identity with both user and group sponsors.

### Example 3: Create an agent identity with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "Finance Blueprint" -SponsorUserIds @("finance-admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Finance Agent"
```

This example creates an Agent Identity. The cmdlet will prompt for sponsors and owners if not provided.

## PARAMETERS

### -DisplayName

The display name for the Agent Identity.

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

### -SponsorUserIds

Array of user IDs to set as sponsors.

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

### -SponsorGroupIds

Array of group IDs to set as sponsors.

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

### -OwnerUserIds

Array of user IDs to set as owners.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

Returns the Agent Identity object with properties including id, displayName, appId, and AgentIdentityBlueprintId.

## NOTES

Requires an Agent Identity Blueprint to be created first (uses stored blueprint ID). At least one owner or sponsor (user or group) must be specified. The cmdlet stores the Agent Identity ID in a module-level variable for use by other related cmdlets.

This cmdlet requires the following Microsoft Graph permissions:
- AgentIdentityBlueprint.Create
- Application.ReadWrite.All

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Get-EntraBetaAgentIdentity](Get-EntraBetaAgentIdentity.md)

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)
