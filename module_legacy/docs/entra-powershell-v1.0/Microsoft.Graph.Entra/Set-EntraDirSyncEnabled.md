---
title: Set-EntraDirSyncEnabled
description: This article provides details on the Set-EntraDirSyncEnabled command.


ms.topic: reference
ms.date: 09/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraDirSyncEnabled

schema: 2.0.0
---

# Set-EntraDirSyncEnabled

## Synopsis

Turns directory synchronization on or off for a company.

## Syntax

```powershell
Set-EntraDirSyncEnabled
 -EnableDirSync <Boolean> 
 [-Force] 
 [-TenantId <String>] 
 [<CommonParameters>]
```

## Description

The `Set-EntraDirSyncEnabled` cmdlet turns directory synchronization on or off for a company.
>[!IMPORTANT]
>It may take up to 72 hours to complete deactivation once you have disabled DirSync through this cmdlet. The time depends on the number of objects that are in your cloud service subscription account. **You cannot cancel the disable action**. It will need to complete before you can take any other action, including re-enabling of DirSync. If you choose to re-enable DirSync, a full synchronization of your synced objects will happen. This may take a considerable time depending on the number of objects in your Microsoft Entra ID.
>[!NOTE]
>If you disable DirSync and you decide to re-enable it, and you have enabled the BlockCloudObjectTakeoverThroughHardMatch feature, OnPrem to cloud object takeover/update for all objects mastered in the Microsoft Entra ID will be blocked. If this is the case and you want to resume syncing Microsoft Entra ID mastered objects with Microsoft Entra ID, set **BlockCloudObjectTakeoverThroughHardMatch** feature to false.

## Examples

### Example 1: Turn on directory synchronization

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All'
$params = @{
    EnableDirsync = $True 
    Force = $True
}
Set-EntraDirSyncEnabled @params
```

This example turns on directory synchronization for a company.

- `-EnableDirsync` Specifies whether to turn on directory synchronization on for your company.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Turn off directory synchronization

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All'
$params = @{
    EnableDirsync = $False 
    TenantId = 'aaaaaaaa-1111-1111-1111-000000000000'
    Force = $True
    
}
Set-EntraDirSyncEnabled @params
```

This example turns off directory synchronization for a company.

- `-EnableDirsync` Specifies whether to turn on directory synchronization on for your company.
- `-Force` Forces the command to run without asking for user confirmation.
- `-TenantId` Specifies the unique ID of the tenant on which to perform the operation.

## Parameters

### -EnableDirsync

Specifies whether to turn on directory synchronization on for your company.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:
Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId

Specifies the unique ID of the tenant on which to perform the operation.
The default value is the tenant of the current user.
This parameter applies only to partner users.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
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

## Inputs

## Outputs

## Notes

## Related Links
