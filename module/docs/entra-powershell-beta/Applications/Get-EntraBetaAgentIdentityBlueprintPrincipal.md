---
author: givinalis
description: This article provides details on the Get-EntraBetaAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 04/25/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: Get-EntraBetaAgentIdentityBlueprintPrincipal
---

# Get-EntraBetaAgentIdentityBlueprintPrincipal

## SYNOPSIS

Gets an Agent Identity Blueprint Service Principal by its ID.

## SYNTAX

```powershell
Get-EntraBetaAgentIdentityBlueprintPrincipal
 [-ServicePrincipalId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAgentIdentityBlueprintPrincipal` cmdlet retrieves an Agent Identity Blueprint Service Principal from Microsoft Graph using the provided Service Principal ID. If no ID is provided, it uses the stored service principal ID from the current session or prompts for one. Returns the service principal object if found, or throws an error if not found.

## EXAMPLES

### Example 1: Get a Blueprint Service Principal by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaAgentIdentityBlueprintPrincipal -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

This example retrieves the Agent Identity Blueprint Service Principal with the specified ID.

### Example 2: Get the Blueprint Service Principal from the current session

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprintPrincipal.Create'
New-EntraBetaAgentIdentityBlueprintPrincipal
$sp = Get-EntraBetaAgentIdentityBlueprintPrincipal
Write-Host "Service Principal: $($sp.displayName)"
```

This example retrieves the Agent Identity Blueprint Service Principal that was created in the current session using the stored service principal ID.

### Example 3: Get a Blueprint Service Principal with error handling

```powershell
Connect-Entra -Scopes 'Application.Read.All'
try {
    $sp = Get-EntraBetaAgentIdentityBlueprintPrincipal -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    Write-Host "Service Principal found: $($sp.displayName)"
} catch {
    Write-Host "Service Principal not found or error occurred: $_"
}
```

This example demonstrates how to retrieve an Agent Identity Blueprint Service Principal with error handling to catch cases where it doesn't exist.

## PARAMETERS

### -ServicePrincipalId

The ID of the Agent Identity Blueprint Service Principal to retrieve. If not provided, uses the stored service principal ID from the current session or prompts for one.

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

Returns the Agent Identity Blueprint Service Principal object with properties including id, appId, displayName, createdDateTime, and servicePrincipalType.

## NOTES

If the Agent Identity Blueprint Service Principal with the specified ID is not found, the cmdlet will throw an error.

This cmdlet requires the following Microsoft Graph permissions:
- Application.Read.All

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Get-EntraBetaAgentIdentityBlueprint](Get-EntraBetaAgentIdentityBlueprint.md)
