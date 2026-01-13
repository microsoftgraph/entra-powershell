---
author: givinalis
description: This article provides details on the Get-EntraBetaAgentIdentity command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaAgentIdentity
schema: 2.0.0
title: Get-EntraBetaAgentIdentity
---

# Get-EntraBetaAgentIdentity

## SYNOPSIS

Gets an Agent Identity by its ID.

## SYNTAX

```powershell
Get-EntraBetaAgentIdentity
 -AgentId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAgentIdentity` cmdlet retrieves an Agent Identity from Microsoft Graph using the provided Agent ID. Returns the agent identity object if found, or throws an error if not found.

## EXAMPLES

### Example 1: Get an Agent Identity by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaAgentIdentity -AgentId "27a3cf14-5bdc-4814-bb13-8f1740ca9a4f"
```

This example retrieves the Agent Identity with the specified ID.

### Example 2: Get an Agent Identity with error handling

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

The ID of the Agent Identity to retrieve.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

Returns the Agent Identity object with properties including id, displayName, appId, and other agent identity details.

## NOTES

If the Agent Identity with the specified ID is not found, the cmdlet will throw an error.

## RELATED LINKS

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)
