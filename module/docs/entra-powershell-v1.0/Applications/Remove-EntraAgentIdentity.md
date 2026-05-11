---
author: givinalis
description: This article provides details on the Remove-EntraAgentIdentity command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Remove-EntraAgentIdentity
schema: 2.0.0
title: Remove-EntraAgentIdentity
---

# Remove-EntraAgentIdentity

## SYNOPSIS

Deletes an Agent Identity by its ID, or deletes all Agent Identities (and their Agent Users) associated with an Agent Identity Blueprint.

## SYNTAX

### ByAgentId (Default)

```powershell
Remove-EntraAgentIdentity
 -AgentId <String>
 [-Force]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

### ByBlueprintId

```powershell
Remove-EntraAgentIdentity
 -AgentIdentityBlueprintId <String>
 [-Force]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraAgentIdentity` cmdlet deletes Agent Identities from Microsoft Entra using the v1.0 API. When used with `-AgentId`, it deletes a single Agent Identity and any associated Agent Users. When used with `-AgentIdentityBlueprintId`, it looks up all Agent Identities for the blueprint and deletes each one along with their associated Agent Users.

The cmdlet requires confirmation before deleting unless the `-Force` switch is used. Use `-WhatIf` to preview which resources would be deleted without actually performing the deletion.

## EXAMPLES

### Example 1: Delete an Agent Identity by ID

```powershell
Connect-Entra -Scopes 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
Remove-EntraAgentIdentity -AgentId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force
```

This example deletes the Agent Identity and any associated Agent Users.

### Example 2: Delete all Agent Identities for a Blueprint

```powershell
Connect-Entra -Scopes 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
Remove-EntraAgentIdentity -AgentIdentityBlueprintId "cccccccc-3333-4444-5555-dddddddddddd" -Force
```

This example looks up all Agent Identities associated with the specified Blueprint, deletes their Agent Users, and then deletes the Agent Identities themselves.

### Example 3: Preview deletion with WhatIf

```powershell
Connect-Entra -Scopes 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
Remove-EntraAgentIdentity -AgentIdentityBlueprintId "cccccccc-3333-4444-5555-dddddddddddd" -WhatIf
```

This example shows which Agent Identities and Agent Users would be deleted without performing the deletion.

### Example 4: Delete with error handling

```powershell
Connect-Entra -Scopes 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
try {
    $result = Remove-EntraAgentIdentity -AgentId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force
    Write-Host "Deleted Agent Identity: $($result.DisplayName)"
    Write-Host "Also deleted $($result.DeletedAgentUsers.Count) Agent User(s)"
} catch {
    Write-Host "Failed to delete: $_"
}
```

This example demonstrates how to delete an Agent Identity with error handling and inspect the deleted Agent Users.

## PARAMETERS

### -AgentId

The ID of the Agent Identity to delete. The cmdlet will also delete any Agent Users associated with this Agent Identity. Used with the ByAgentId parameter set.

```yaml
Type: System.String
Parameter Sets: ByAgentId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentIdentityBlueprintId

The ID of the Agent Identity Blueprint. All Agent Identities associated with this blueprint will be deleted, along with their Agent Users. Used with the ByBlueprintId parameter set.

```yaml
Type: System.String
Parameter Sets: ByBlueprintId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Suppresses the confirmation prompt before deleting.

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

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Collections.Hashtable

Returns a hashtable (or array of hashtables when using `-AgentIdentityBlueprintId`) with properties: Id, DisplayName, AgentIdentityBlueprintId, DeletedAgentUsers (array of deleted user info), and Status.

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- AgentIdentity.DeleteRestore.All
- AgentIdUser.ReadWrite.All

The cmdlet requires an active Microsoft Entra connection. Use `Connect-Entra` with the above scopes to connect first.

When deleting an Agent Identity, any associated Agent Users are deleted first. If Agent User deletion fails, the error is logged but the Agent Identity deletion still proceeds.

When using `-AgentIdentityBlueprintId`, the cmdlet supports pagination to handle blueprints with many Agent Identities.

## RELATED LINKS

[Get-EntraAgentIdentity](Get-EntraAgentIdentity.md)

[New-EntraAgentIDForAgentIdentityBlueprint](New-EntraAgentIDForAgentIdentityBlueprint.md)

[Remove-EntraAgentUser](../Users/Remove-EntraAgentUser.md)

[Get-EntraAgentIdentityBlueprint](Get-EntraAgentIdentityBlueprint.md)
