---
author: msewaweru
description: This article provides details on the Get-EntraObjectSetting command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/03/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraObjectSetting
schema: 2.0.0
title: Get-EntraObjectSetting
---

# Get-EntraObjectSetting

## SYNOPSIS

Gets an object setting.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraObjectSetting
 [-Top <Int32>]
 [-All]
 -TargetType <String>
 -TargetObjectId <String>
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraObjectSetting
 -Id <String> [-All]
 -TargetType <String>
 -TargetObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraObjectSetting` cmdlet retrieves an object setting from Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

### Example 2: Retrieve a specific object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
$setting = Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id | Where-Object {$_.displayName -eq 'Group.Unified.Guest'}
Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id -Id $setting.Id
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves Specific object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.
- `-Id` Parameter specifies the ID of a settings object.

### Example 3: Retrieve top one object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id -Top 1
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves top one object setting from Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

### Example 4: Retrieve all object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id -All
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves all records of object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

### Example 5: Retrieve user object settings

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$user = Get-EntraUser -UserId 'AdeleV@Contoso.com'
Get-EntraObjectSetting -TargetType 'Users' -TargetObjectId $user.Id
```

```Output
Id ContributionToContentDiscoveryAsOrganizationDisabled ContributionToContentDiscoveryDisabled
-- ---------------------------------------------------- --------------------------------------
   False                                                False
```

This command retrieves user object setting.

- `-TargetType` Parameter specifies the user target type.
- `-TargetObjectId` Parameter specifies the ID of the user.

## PARAMETERS

### -All

List all pages.

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

### -Id

Specifies the ID of a settings object.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetObjectId

Specifies the ID of the target object.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetType

Specifies the target type.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

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
