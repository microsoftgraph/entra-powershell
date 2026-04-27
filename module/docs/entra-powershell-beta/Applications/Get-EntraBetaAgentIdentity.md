---
author: givinalis
description: This article provides details on the Get-EntraBetaAgentIdentity command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 04/25/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaAgentIdentity
schema: 2.0.0
title: Get-EntraBetaAgentIdentity
---

# Get-EntraBetaAgentIdentity

## SYNOPSIS

Gets an Agent Identity by its ID, or lists all Agent Identities for an Agent Identity Blueprint.

## SYNTAX

### GetById (Default)

```powershell
Get-EntraBetaAgentIdentity
 -AgentId <String>
 [<CommonParameters>]
```

### GetByBlueprint

```powershell
Get-EntraBetaAgentIdentity
 [-AgentIdentityBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAgentIdentity` cmdlet retrieves an Agent Identity from Microsoft Graph. When used with `-AgentId`, it returns a single agent identity. When used with `-AgentIdentityBlueprintId`, it returns all agent identities that are children of the specified blueprint. If no blueprint ID is provided, uses the stored blueprint ID from the current session or prompts for one.

## EXAMPLES

### Example 1: Get an Agent Identity by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaAgentIdentity -AgentId "27a3cf14-5bdc-4814-bb13-8f1740ca9a4f"
```

This example retrieves the Agent Identity with the specified ID.

### Example 2: List all Agent Identities for a Blueprint

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$agents = Get-EntraBetaAgentIdentity -AgentIdentityBlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
$agents | ForEach-Object { Write-Host "$($_.displayName) ($($_.id))" }
```

This example retrieves all Agent Identities that are children of the specified Agent Identity Blueprint.

### Example 3: List Agent Identities for the current session Blueprint

```powershell
Connect-Entra -Scopes 'Application.Read.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
$agents = Get-EntraBetaAgentIdentity -AgentIdentityBlueprintId
$agents | ForEach-Object { Write-Host "$($_.displayName)" }
```

This example lists all Agent Identities for the blueprint created in the current session using the stored blueprint ID.

### Example 4: Get an Agent Identity with error handling

```powershell
Connect-Entra -Scopes 'Application.Read.All'
try {
    $agent = Get-EntraBetaAgentIdentity -AgentId "27a3cf14-5bdc-4814-bb13-8f1740ca9a4f"
    Write-Host "Agent found: $($agent.displayName)"
} catch {
    Write-Host "Agent not found or error occurred: $_"
}
```

This example demonstrates how to retrieve an Agent Identity with error handling to catch cases where the agent doesn't exist.

## PARAMETERS

### -AgentId

The ID of the Agent Identity to retrieve. Used with the GetById parameter set.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentIdentityBlueprintId

The ID of the Agent Identity Blueprint to list child agent identities for. If not provided, uses the stored blueprint ID from the current session or prompts for one. Used with the GetByBlueprint parameter set.

```yaml
Type: System.String
Parameter Sets: GetByBlueprint
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

When using `-AgentId`, returns a single Agent Identity object. When using `-AgentIdentityBlueprintId`, returns an array of Agent Identity objects. Each object includes properties such as id, displayName, appId, and servicePrincipalType.

## NOTES

If the Agent Identity or Blueprint with the specified ID is not found, the cmdlet will throw an error. When listing by blueprint, supports pagination to retrieve all results.

This cmdlet requires the following Microsoft Graph permissions:
- Application.Read.All

## RELATED LINKS

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Get-EntraBetaAgentIdentityBlueprint](Get-EntraBetaAgentIdentityBlueprint.md)
