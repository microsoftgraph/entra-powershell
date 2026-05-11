---
author: givinalis
description: This article provides details on the Add-EntraRequiredResourceAccessToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Add-EntraRequiredResourceAccessToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraRequiredResourceAccessToAgentIdentityBlueprint
---

# Add-EntraRequiredResourceAccessToAgentIdentityBlueprint

## SYNOPSIS

Adds required resource access (API permissions) to an Agent Identity Blueprint application.

## SYNTAX

```powershell
Add-EntraRequiredResourceAccessToAgentIdentityBlueprint
 [-AgentBlueprintId <String>]
 [-ResourceAppId <Guid>]
 [-ResourceAccess <Hashtable[]>]
 [-Silent]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraRequiredResourceAccessToAgentIdentityBlueprint` cmdlet adds required resource access entries (API permissions) to an Agent Identity Blueprint. This configures which API permissions (delegated scopes or application roles) the blueprint application requires. The cmdlet retrieves existing required resource access entries, merges new permissions without duplicating existing ones, and PATCHes the updated list back to the application.

In interactive mode, the cmdlet prompts for the resource application ID, permission type (scope or role), and permission GUID. It supports searching available permissions by name when the resource service principal is discoverable. In silent mode, all required parameters must be provided via command-line arguments.

## EXAMPLES

### Example 1: Add permissions interactively

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraRequiredResourceAccessToAgentIdentityBlueprint
```

This example adds required resource access interactively. The cmdlet prompts for the resource application, permission type, and permission GUID.

### Example 2: Add permissions in silent mode

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
$permissions = @(
    @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" },
    @{ id = "df021288-bdef-4463-88db-98f22de89214"; type = "Role" }
)
Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
```

This example adds Microsoft Graph delegated and application permissions to the current Agent Identity Blueprint without interactive prompts.

### Example 3: Add permissions to a specific blueprint

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
$permissions = @(
    @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
)
Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -AgentBlueprintId "12345678-1234-1234-1234-123456789012" -ResourceAppId "00000003-0000-0000-c000-000000000000" -ResourceAccess $permissions -Silent
```

This example adds a specific Microsoft Graph delegated permission to a specified Agent Identity Blueprint.

## PARAMETERS

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to add required resource access to. If not provided, uses the stored ID from the last blueprint creation, or prompts interactively.

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

### -ResourceAppId

The resource application ID (GUID) to add permissions for. Defaults to Microsoft Graph (00000003-0000-0000-c000-000000000000).

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 00000003-0000-0000-c000-000000000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceAccess

Array of hashtable entries specifying the permissions to add. Each entry must have an 'id' (GUID of the permission) and 'type' ('Scope' for delegated permissions or 'Role' for application permissions).

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent

Run in silent mode with no interactive prompts. Requires ResourceAccess to be provided with at least one entry.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

Returns an array of PSCustomObject entries, one per resource application configured. Each entry contains: AgentBlueprintId, ResourceAppId, ResourceAppName, Permissions (array of Id/Type/DisplayName), ConfiguredAt, and ApiResponse.

## NOTES

This cmdlet uses the Microsoft Graph v1.0 API endpoint (`/v1.0/applications/{id}`).

This cmdlet requires the following Microsoft Graph permission: AgentIdentityBlueprint.ReadWrite.All

The cmdlet merges new permissions with existing required resource access entries rather than overwriting them. Duplicate permissions (same id and type) are skipped. The cmdlet includes retry logic (up to 10 attempts with 10-second intervals) to handle propagation delays.

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint](../../../entra-powershell-beta/Applications/Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint.md)
