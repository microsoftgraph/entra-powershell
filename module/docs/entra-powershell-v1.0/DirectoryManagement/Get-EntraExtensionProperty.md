---
author: msewaweru
description: This article provides details on the Get-EntraExtensionProperty command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraExtensionProperty
schema: 2.0.0
title: Get-EntraExtensionProperty
---

# Get-EntraExtensionProperty

## Synopsis

Gets extension properties registered with Microsoft Entra ID.

## Syntax

```powershell
Get-EntraExtensionProperty
 [-IsSyncedFromOnPremises <Boolean>]
 [-Name <String>]
 [-WhatIf]
 [-Confirm]
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
Id                                   AppDisplayName DataType IsMultiValued IsSyncedFromOnPremises Name                                                         TargetObjects
--                                   -------------- -------- ------------- ---------------------- ----                                                         -------------
bd647a28-ae50-4e03-a915-067da7ff6cec Contoso App          String   False         False                  extension_12345_JobGroup          {User}
daa3b0e4-b14c-40a4-bb91-a2c017ac2b28 Contoso App          String   False         False                  extension_12345_CostCenter            {User}
4113c724-f8c3-4fdf-ac5b-b1cf1440ff55 Contoso App          String   False         False                  extension_12345_EmploymentNumber             {}
```

This command gets extension properties that have sync from on-premises Microsoft Entra ID.

### Example 2: Get extension properties using extension name

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraExtensionProperty -IsSyncedFromOnPremises $False -Name extension_12345_JobGroup
```

```Output
Id                                   AppDisplayName DataType IsMultiValued IsSyncedFromOnPremises Name                                                         TargetObjects
--                                   -------------- -------- ------------- ---------------------- ----                                                         -------------
bd647a28-ae50-4e03-a915-067da7ff6cec Contoso App     String   False         False                  extension_12345_JobGroup          {User}
```

This command retrieves extension based on the extension name (client-side filtering).

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

### -Name

Filter using the extension name.

```yaml
Type: System.String
Parameter Sets: Default
Aliases:

Required: True
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
