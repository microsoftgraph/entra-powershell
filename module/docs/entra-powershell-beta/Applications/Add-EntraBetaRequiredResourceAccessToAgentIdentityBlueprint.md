---
description: This article provides details on the Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint
---

# Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint

## SYNOPSIS

Adds required resource access to an Agent Identity Blueprint application.

## SYNTAX

```powershell
Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint
 [-AgentBlueprintId <String>]
 [-ResourceAppId <Guid>]
 [-ResourceAccess <Hashtable[]>]
 [-Silent]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint` cmdlet adds required resource access to an Agent Identity Blueprint application. It specifies the resources the application needs to access along with the set of delegated permissions (Scope) and application roles (Role) required for each resource. The cmdlet merges new permissions with any existing required resource access entries on the blueprint.

If no `-AgentBlueprintId` is provided, the cmdlet uses the stored blueprint ID from the last blueprint creation. If no stored ID exists, it prompts for one interactively.

## EXAMPLES

### Example 1: Add required resource access with interactive prompts

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint
```

This example interactively prompts for the resource application, permission type, and permission GUID to add to the current Agent Identity Blueprint.

### Example 2: Add specific delegated permissions for Microsoft Graph

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
$permissions = @(
    @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" },
    @{ id = "570282fd-fa5c-430d-a7fd-fc8dc98a9dca"; type = "Scope" }
)
Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions
```

This example adds User.Read and Mail.Read delegated permissions from Microsoft Graph to the Agent Identity Blueprint.

### Example 3: Add application role for a custom resource with explicit blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
$permissions = @(
    @{ id = "df021288-bdef-4463-88db-98f22de89214"; type = "Role" }
)
Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -AgentBlueprintId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -ResourceAppId "12345678-1234-1234-1234-123456789012" -ResourceAccess $permissions
```

This example adds an application role permission for a custom resource application using an explicit blueprint ID.

### Example 4: Add permissions in silent mode (non-interactive)

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All'
$permissions = @(
    @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
)
Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -AgentBlueprintId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -ResourceAccess $permissions -Silent
```

This example adds permissions without interactive prompts, which is useful for scripted automation scenarios. Silent mode requires `-ResourceAccess` to be provided.

## PARAMETERS

### -AgentBlueprintId

The object ID of the Agent Identity Blueprint application to add required resource access to. If not provided, uses the stored blueprint ID from the last blueprint creation, or prompts interactively.

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

The resource application ID as a GUID. Defaults to Microsoft Graph (00000003-0000-0000-c000-000000000000). This identifies the API that the blueprint application needs access to.

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

Array of hashtable entries specifying the permissions to add. Each hashtable must contain an `id` key (the GUID of the permission) and a `type` key (`Scope` for delegated permissions or `Role` for application roles). If not provided, the cmdlet prompts interactively.

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

Runs the cmdlet in non-interactive mode with no prompts. When specified, the cmdlet adds only the permissions provided via `-ResourceAccess` and does not prompt for additional resources. Requires `-ResourceAccess` to be provided with at least one entry.

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

Returns a collection of objects with the following properties:

- **AgentBlueprintId** - The object ID of the Agent Identity Blueprint.
- **ResourceAppId** - The resource application GUID.
- **ResourceAppName** - Display name of the resource (e.g., "Microsoft Graph", "Azure Active Directory Graph", or "Custom Resource").
- **Permissions** - Array of permission details, each with `Id`, `Type` (Scope or Role), and `DisplayName`.
- **ConfiguredAt** - The timestamp when the configuration was applied.
- **ApiResponse** - The raw API response from the PATCH operation.

## NOTES

This cmdlet requires the following Microsoft Graph permission:

- AgentIdentityBlueprint.ReadWrite.All

This cmdlet requires an Agent Identity Blueprint to be created first. It uses the stored blueprint ID from the last blueprint creation. The cmdlet merges new permissions with existing required resource access entries, preserving any previously configured permissions. Duplicate permissions (same id and type) for the same resource are automatically skipped.

The cmdlet looks up the service principal for the target resource to provide a searchable list of available permissions during interactive mode.

The cmdlet includes retry logic (up to 10 attempts with 10-second waits) to handle propagation delays in Microsoft Entra.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint](Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint.md)
