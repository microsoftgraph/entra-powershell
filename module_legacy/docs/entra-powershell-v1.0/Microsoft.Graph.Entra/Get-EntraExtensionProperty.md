---
title: Get-EntraExtensionProperty
description: This article provides details on the Get-EntraExtensionProperty command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraExtensionProperty

schema: 2.0.0
---

# Get-EntraExtensionProperty

## Synopsis

Gets extension properties registered with Microsoft Entra ID.

## Syntax

```powershell
Get-EntraExtensionProperty
 [-IsSyncedFromOnPremises <Boolean>]
 [<CommonParameters>]
```

## Description

The Get-EntraExtensionProperty cmdlet gets a collection that contains the extension properties registered with Microsoft Entra ID through Microsoft Entra ID Connect.

You can get extension properties that are synced with on-premises Microsoft Entra ID that aren't synced with on-premises Microsoft Entra ID or both types.

This command returns all directory extension definitions registered in a directory, including those from multitenant apps. The following entities support extension properties:

- User
- Group
- AdministrativeUnit
- Application
- Device
- Organization

## Examples

### Example 1: Get extension properties synced from on-premises Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraExtensionProperty -IsSyncedFromOnPremises $True
```

```Output
DeletedDateTime Id                                   AppDisplayName              DataType IsMultiValued IsSyncedFromOnPremises Name                                                           TargetObjects
--------------- --                                   --------------              -------- ------------- ---------------------- ----                                                           -------------
                aaaabbbb-0000-cccc-1111-dddd2222eeee Tenant Schema Extension App String   False         True                   extension_aaaabbbb-0000-cccc-1111-dddd2222eeee_extensionAttribute1 {User}
```

This command gets extension properties that have sync from on-premises Microsoft Entra ID.

## Parameters

### -IsSyncedFromOnPremises

Specifies whether this cmdlet gets extension properties that are synced or not synced.

- `$True` - get extension properties that are synced from the on-premises Microsoft Entra ID.
- `$False` - get extension properties that aren't synced from the on-premises Microsoft Entra ID.
- `No value` - get all extension properties (both synced and nonsynced).

```yaml
Type: System.Boolean
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

## Related links
