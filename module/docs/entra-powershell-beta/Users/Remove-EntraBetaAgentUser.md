---
author: givinalis
description: This article provides details on the Remove-EntraBetaAgentUser command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Users
ms.author: giomachar
ms.date: 04/26/2026
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Remove-EntraBetaAgentUser
schema: 2.0.0
title: Remove-EntraBetaAgentUser
---

# Remove-EntraBetaAgentUser

## SYNOPSIS

Deletes an Agent User by its ID, or deletes all Agent Users associated with an Agent Identity.

## SYNTAX

### ByUserId (Default)

```powershell
Remove-EntraBetaAgentUser
 -AgentUserId <String>
 [-Force]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

### ByAgentId

```powershell
Remove-EntraBetaAgentUser
 -AgentId <String>
 [-Force]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaAgentUser` cmdlet deletes Agent Users from Microsoft Entra. When used with `-AgentUserId`, it deletes a single agent user by ID. When used with `-AgentId`, it looks up and deletes all agent users associated with the specified Agent Identity.

The cmdlet requires confirmation before deleting unless the `-Force` switch is used. Use `-WhatIf` to preview which users would be deleted without actually performing the deletion.

## EXAMPLES

### Example 1: Delete an Agent User by ID

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentUser -AgentUserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

This example deletes the Agent User with the specified ID. You will be prompted for confirmation.

### Example 2: Delete an Agent User by ID without confirmation

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentUser -AgentUserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force
```

This example deletes the Agent User without prompting for confirmation.

### Example 3: Delete all Agent Users for an Agent Identity

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentUser -AgentId "cccccccc-3333-4444-5555-dddddddddddd" -Force
```

This example looks up all Agent Users associated with the specified Agent Identity and deletes them.

### Example 4: Preview deletion with WhatIf

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
Remove-EntraBetaAgentUser -AgentId "cccccccc-3333-4444-5555-dddddddddddd" -WhatIf
```

This example shows which Agent Users would be deleted without actually performing the deletion.

### Example 5: Delete with error handling

```powershell
Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'
try {
    $result = Remove-EntraBetaAgentUser -AgentUserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force
    Write-Host "Deleted: $($result.DisplayName)"
} catch {
    Write-Host "Failed to delete: $_"
}
```

This example demonstrates how to delete an Agent User with error handling.

## PARAMETERS

### -AgentUserId

The ID of the Agent User to delete. Used with the ByUserId parameter set.

```yaml
Type: System.String
Parameter Sets: ByUserId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentId

The ID of the Agent Identity whose associated Agent Users should be deleted. The cmdlet looks up all Agent Users connected to this Agent Identity and deletes them. Used with the ByAgentId parameter set.

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

Returns a hashtable (or array of hashtables when using `-AgentId`) with the following properties: Id, DisplayName, AgentId, and Status.

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- AgentIdUser.ReadWrite.All

The cmdlet requires an active Microsoft Entra connection. Use `Connect-Entra -Scopes 'AgentIdUser.ReadWrite.All'` to connect first.

When using `-AgentId`, the cmdlet first queries for all Agent Users associated with the Agent Identity, then deletes each one. If the Agent Identity has no associated Agent Users, a warning is displayed.

## RELATED LINKS

[New-EntraBetaAgentUserForAgentId](New-EntraBetaAgentUserForAgentId.md)

[Get-EntraBetaAgentUser](Get-EntraBetaAgentUser.md)

[Get-EntraBetaAgentIdentity](../Applications/Get-EntraBetaAgentIdentity.md)
