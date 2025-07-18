---
author: msewaweru
description: This article provides details on the Set-EntraBetaDirSyncEnabled command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/20/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaDirSyncEnabled
schema: 2.0.0
title: Set-EntraBetaDirSyncEnabled
---

# Set-EntraBetaDirSyncEnabled

## SYNOPSIS

Turns directory synchronization on or off for a company.

## SYNTAX

```powershell
Set-EntraBetaDirSyncEnabled
 -EnableDirSync <Boolean>
 [-Force]
 [-TenantId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaDirSyncEnabled` cmdlet turns directory synchronization on or off for a company.

A new service principal appears in your tenant when you enable or reenable DirSync. It has the appId `6bf85cfa-ac8a-4be5-b5de-425a0d0dc016` and the display name **Microsoft Entra AD Synchronization Service**.

Deactivating DirSync may take up to 72 hours, depending on the number of objects in your cloud subscription. Once disabled, the process cannot be canceled and must complete before you can take further action, including re-enabling DirSync.

If you re-enable DirSync, a full synchronization will occur, which may take significant time based on the number of objects in Microsoft Entra ID.

Additionally, if `BlockCloudObjectTakeoverThroughHardMatch` is enabled, re-enabling DirSync will block On-Prem to cloud object takeover/updates for all Microsoft Entra ID-mastered objects. To allow syncing of these objects, set `BlockCloudObjectTakeoverThroughHardMatch` to false.

## EXAMPLES

### Example 1: Turn on directory synchronization

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All'
Set-EntraBetaDirSyncEnabled -EnableDirsync $true -Force $true
```

This example turns on directory synchronization for a company.

- `-EnableDirsync` Specifies whether to turn on directory synchronization on for your company.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Turn off directory synchronization

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All'
$tenantID = (Get-EntraContext).TenantId
Set-EntraBetaDirSyncEnabled -EnableDirsync $false -TenantId $tenantID -Force
```

This example turns off directory synchronization for a company.

- `-EnableDirsync` Specifies whether to turn on directory synchronization on for your company.
- `-Force` Forces the command to run without asking for user confirmation.
- `-TenantId` Specifies the unique ID of the tenant on which to perform the operation.

## PARAMETERS

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

Specifies the unique ID of the tenant on which to perform the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
