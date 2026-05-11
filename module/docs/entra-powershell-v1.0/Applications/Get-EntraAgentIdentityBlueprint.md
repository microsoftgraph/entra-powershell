---
author: givinalis
description: This article provides details on the Get-EntraAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Get-EntraAgentIdentityBlueprint
schema: 2.0.0
title: Get-EntraAgentIdentityBlueprint
---

# Get-EntraAgentIdentityBlueprint

## SYNOPSIS

Gets an Agent Identity Blueprint by its ID.

## SYNTAX

```powershell
Get-EntraAgentIdentityBlueprint
 [-BlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraAgentIdentityBlueprint` cmdlet retrieves an Agent Identity Blueprint from Microsoft Graph using the v1.0 API and the provided Blueprint ID. If no ID is provided, it uses the stored blueprint ID from the current session or prompts for one. Returns the blueprint object if found, or throws an error if not found.

## EXAMPLES

### Example 1: Get an Agent Identity Blueprint by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraAgentIdentityBlueprint -BlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

This example retrieves the Agent Identity Blueprint with the specified ID.

### Example 2: Get the blueprint from the current session

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("admin@contoso.com")
$blueprint = Get-EntraAgentIdentityBlueprint
Write-Host "Blueprint: $($blueprint.displayName)"
```

This example retrieves the Agent Identity Blueprint that was created in the current session using the stored blueprint ID.

### Example 3: Get an Agent Identity Blueprint with error handling

```powershell
Connect-Entra -Scopes 'Application.Read.All'
try {
    $blueprint = Get-EntraAgentIdentityBlueprint -BlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    Write-Host "Blueprint found: $($blueprint.displayName)"
} catch {
    Write-Host "Blueprint not found or error occurred: $_"
}
```

This example demonstrates how to retrieve an Agent Identity Blueprint with error handling to catch cases where the blueprint doesn't exist.

## PARAMETERS

### -BlueprintId

The ID of the Agent Identity Blueprint to retrieve. If not provided, uses the stored blueprint ID from the current session or prompts for one.

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

Returns the Agent Identity Blueprint object with properties including id, appId, displayName, createdDateTime, and requiredResourceAccess.

## NOTES

If the Agent Identity Blueprint with the specified ID is not found, the cmdlet will throw an error.

This cmdlet uses the Microsoft Graph v1.0 API endpoint (`/v1.0/applications/microsoft.graph.agentIdentityBlueprint`).

This cmdlet requires the following Microsoft Graph permissions:
- Application.Read.All

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](../../../entra-powershell-beta/Applications/New-EntraBetaAgentIdentityBlueprint.md)
