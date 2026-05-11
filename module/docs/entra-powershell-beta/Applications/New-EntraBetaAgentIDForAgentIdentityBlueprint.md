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
 [-AgentIdentityBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentIDForAgentIdentityBlueprint` cmdlet creates a new Agent Identity by posting to the Microsoft Graph AgentIdentity endpoint using the specified or stored Agent Identity Blueprint ID and specified sponsors/owners. At least one sponsor (user or group) is required. Owners are optional. If the `AgentIdentityBlueprintId` parameter is not provided, the cmdlet uses the stored blueprint ID from a previous `New-EntraBetaAgentIdentityBlueprint` call. If no stored ID exists, the cmdlet prompts interactively. If sponsors or owners are not provided as parameters, the cmdlet prompts interactively and suggests the current user as the default. All user IDs and UPNs are validated against the tenant before the Agent Identity is created. Duplicate entries are automatically removed.

## EXAMPLES

### Example 1: Create an agent identity with sponsors and owners

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "My Agent Identity" -SponsorUserIds @("user1@contoso.com") -OwnerUserIds @("owner1@contoso.com")
```

This example creates an Agent Identity with the specified display name, sponsors, and owners using the Agent Identity Blueprint created in the current session.

### Example 2: Create an agent identity with user and group sponsors

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "HR Agent" -SponsorUserIds @("hr-admin@contoso.com") -SponsorGroupIds @("aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb")
```

This example creates an Agent Identity with both user and group sponsors.

### Example 3: Create an agent identity with prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All'
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

Array of user IDs or UPNs to set as sponsors.

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

Array of user IDs or UPNs to set as owners.

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

### -AgentIdentityBlueprintId

The Agent Identity Blueprint ID (application object ID). If not provided, the cmdlet uses the stored ID from a previous `New-EntraBetaAgentIdentityBlueprint` call. If no stored ID exists, the cmdlet prompts interactively.

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

Returns the Agent Identity object from the Microsoft Graph API response with the following properties:

- **id** — The unique identifier of the created Agent Identity (service principal).
- **appId** — The application ID associated with the Agent Identity.
- **displayName** — The display name of the Agent Identity.
- **createdDateTime** — The date and time the Agent Identity was created.
- **AgentIdentityBlueprintId** — The ID of the parent Agent Identity Blueprint.

Additional properties from the Graph API response may also be included.

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- `AgentIdentity.Create.All`

The cmdlet relies on the stored Agent Identity Blueprint ID (`$script:CurrentAgentBlueprintId`) set by `New-EntraBetaAgentIdentityBlueprint`. If no blueprint ID is stored, the cmdlet fails with an error.

After creating the Agent Identity, the cmdlet stores the ID and AppId in module-level variables (`$script:CurrentAgentIdentityId`, `$script:CurrentAgentIdentityAppId`) and a global variable (`$global:EntraBetaCurrentAgentIdentityId`) for use by other cmdlets.

The cmdlet includes retry logic (up to 10 attempts with 10-second waits) to handle propagation delays.

When sponsor or owner parameters are not provided, the cmdlet enters an interactive mode that:

- Looks up the current signed-in user and offers them as a default sponsor/owner
- Validates all user IDs and UPNs against the tenant, prompting for corrections if a user is not found
- Validates group IDs against the tenant, skipping any that are not found
- Allows adding additional sponsors/owners in iterative prompts

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Get-EntraBetaAgentIdentity](Get-EntraBetaAgentIdentity.md)

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)
