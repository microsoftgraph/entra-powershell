---
author: givinalis
description: This article provides details on the New-EntraBetaAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/New-EntraBetaAgentIdentityBlueprint
schema: 2.0.0
title: New-EntraBetaAgentIdentityBlueprint
---

# New-EntraBetaAgentIdentityBlueprint

## SYNOPSIS

Creates a new Agent Identity Blueprint.

## SYNTAX

```powershell
New-EntraBetaAgentIdentityBlueprint
 -DisplayName <String>
 [-SponsorUserIds <String[]>]
 [-SponsorGroupIds <String[]>]
 [-OwnerUserIds <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaAgentIdentityBlueprint` cmdlet creates a new Agent Identity Blueprint using Microsoft Graph. An Agent Identity Blueprint serves as a template for creating agent identities with consistent configuration and permissions.

## EXAMPLES

### Example 1: Create a blueprint with sponsors and owners

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com") -OwnerUserIds @("owner1@contoso.com")
```

```Output
12345678-1234-1234-1234-123456789012
```

This example creates an Agent Identity Blueprint with the specified display name, sponsors, and owners.

### Example 2: Create a blueprint with user and group sponsors

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "HR Blueprint" -SponsorUserIds @("hr-admin@contoso.com") -SponsorGroupIds @("aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb")
```

```Output
87654321-4321-4321-4321-210987654321
```

This example creates an Agent Identity Blueprint with both user and group sponsors.

### Example 3: Create a blueprint with only user sponsors

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "Finance Blueprint" -SponsorUserIds @("finance-admin@contoso.com", "finance-manager@contoso.com")
```

```Output
11112222-3333-4444-5555-666677778888
```

This example creates an Agent Identity Blueprint with multiple user sponsors.

## PARAMETERS

### -DisplayName

The display name for the Agent Identity Blueprint.

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

### System.String

Returns the Agent Blueprint ID.

## NOTES

At least one owner or sponsor (user or group) must be specified. The cmdlet stores the blueprint ID in a module-level variable for use by other related cmdlets.

This cmdlet requires the following Microsoft Graph permissions:
- AgentIdentityBlueprint.Create
- Application.ReadWrite.All

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)

[Add-EntraBetaClientSecretToAgentIdentityBlueprint](Add-EntraBetaClientSecretToAgentIdentityBlueprint.md)

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)
