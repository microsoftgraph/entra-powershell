---
author: givinalis
description: This article provides details on the Remove-EntraBetaAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Remove-EntraBetaAgentIdentityBlueprint
schema: 2.0.0
title: Remove-EntraBetaAgentIdentityBlueprint
---

# Remove-EntraBetaAgentIdentityBlueprint

## SYNOPSIS

Deletes an Agent Identity Blueprint and all its associated Agent Identities and Agent Users.

## SYNTAX

```powershell
Remove-EntraBetaAgentIdentityBlueprint
 -BlueprintId <String>
 [-Force]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaAgentIdentityBlueprint` cmdlet performs a cascading delete of an Agent Identity Blueprint from Microsoft Entra. It:

1. Finds all Agent Identities associated with the blueprint
2. For each Agent Identity, finds and deletes all associated Agent Users
3. Deletes each Agent Identity
4. Deletes the Agent Identity Blueprint itself

The cmdlet requires confirmation before deleting unless the `-Force` switch is used. Use `-WhatIf` to preview which resources would be deleted without actually performing the deletion.

## EXAMPLES

### Example 1: Delete a Blueprint and all associated resources

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All', 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force
```

This example deletes the blueprint, all its Agent Identities, and all associated Agent Users without prompting for confirmation.

### Example 2: Preview deletion with WhatIf

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All', 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -WhatIf
```

This example shows which resources would be deleted without performing any deletions.

### Example 3: Delete with confirmation and inspect results

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.ReadWrite.All', 'AgentIdentity.DeleteRestore.All', 'AgentIdUser.ReadWrite.All'
$result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
Write-Host "Deleted Blueprint: $($result.BlueprintName)"
Write-Host "Deleted $($result.DeletedIdentities.Count) Agent Identity(ies)"
Write-Host "Deleted $($result.DeletedUsers.Count) Agent User(s)"
```

This example deletes the blueprint with interactive confirmation and inspects the results.

## PARAMETERS

### -BlueprintId

The ID of the Agent Identity Blueprint to delete. The cmdlet will cascade-delete all Agent Identities and Agent Users associated with this blueprint.

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

Returns a hashtable with properties: BlueprintId, BlueprintName, DeletedIdentities (array of deleted Agent Identity info), DeletedUsers (array of deleted Agent User info), and Status.

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- AgentIdentityBlueprint.ReadWrite.All
- AgentIdentity.DeleteRestore.All
- AgentIdUser.ReadWrite.All

The cmdlet requires an active Microsoft Entra connection. Use `Connect-Entra` with the above scopes to connect first.

**Deletion order**: Agent Users are deleted first, then Agent Identities, and finally the blueprint itself. If an individual Agent User or Agent Identity deletion fails, a warning is displayed and the cmdlet continues with the remaining resources.

When the blueprint has many Agent Identities, the cmdlet supports pagination to ensure all are found.

## RELATED LINKS

[Get-EntraBetaAgentIdentityBlueprint](Get-EntraBetaAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Remove-EntraBetaAgentIdentity](Remove-EntraBetaAgentIdentity.md)

[Remove-EntraBetaAgentUser](../Users/Remove-EntraBetaAgentUser.md)
