---
description: This article provides details on the Get-EntraDeletedDevice command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedDevice
schema: 2.0.0
title: Get-EntraDeletedDevice
---

# Get-EntraDeletedDevice

## SYNOPSIS

Retrieves the list of previously deleted devices.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraDeletedDevice
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDeletedDevice
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDeletedDevice
 -DeviceObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDeletedDevice` cmdlet Retrieves the list of previously deleted devices.

## EXAMPLES

### Example 1: Get list of deleted devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -All | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName      DeletionAgeInDays
---------------         --                                   -------------- ----------------------------- --------                             -----------      -------------------
11/11/2024 5:16:25 PM  bbbbbbbb-1111-2222-3333-cccccccccccc False          7/12/2024 8:36:17 PM          aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Network           10
11/6/2024 7:24:39 PM   dddddddd-3333-4444-5555-eeeeeeeeeeee True           10/29/2024 9:07:18 PM         eeeeeeee-4444-5555-6666-ffffffffffff iPhone 12 Pro     15
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Desktop   28
```

This cmdlet retrieves the list of deleted devices.

### Example 2: Get list of deleted devices using All parameter

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -All | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName      DeletionAgeInDays
---------------         --                                   -------------- ----------------------------- --------                             -----------      -------------------
11/11/2024 5:16:25 PM  bbbbbbbb-1111-2222-3333-cccccccccccc False          7/12/2024 8:36:17 PM          aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Network           10
11/6/2024 7:24:39 PM   dddddddd-3333-4444-5555-eeeeeeeeeeee True           10/29/2024 9:07:18 PM         eeeeeeee-4444-5555-6666-ffffffffffff iPhone 12 Pro     15
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Desktop   28
```

This cmdlet retrieves the list of deleted devices using All parameter.

### Example 3: Get top two deleted devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -Top 2 | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName      DeletionAgeInDays
---------------         --                                   -------------- ----------------------------- --------                             -----------      -------------------
11/11/2024 5:16:25 PM  bbbbbbbb-1111-2222-3333-cccccccccccc False          7/12/2024 8:36:17 PM          aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Network           10
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Desktop   28
```

This cmdlet retrieves top two deleted devices. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted devices using SearchString parameter

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -SearchString 'Contoso Desktop' | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName      DeletionAgeInDays
---------------         --                                   -------------- ----------------------------- --------                             -----------      -------------------
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Desktop   28
```

This cmdlet retrieves deleted devices using SearchString parameter.

### Example 5: Get deleted devices filter by display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -Filter "DisplayName eq 'Contoso Desktop'" | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName      DeletionAgeInDays
---------------         --                                   -------------- ----------------------------- --------                             -----------      -------------------
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Desktop   28
```

This cmdlet retrieves deleted devices having specified display name.

### Example 6: Get deleted device by DeviceObjectId

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -DeviceObjectId 'cccccccc-2222-3333-4444-dddddddddddd' | Select-Object DeletedDateTime, Id, AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DisplayName, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName
---------------         --                                   -------------- ----------------------------- --------                             ------
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Woodgrove Desktop
```

This cmdlet retrieves the deleted device specified by DeviceObjectId.

- `-DeviceObjectId` parameter specifies the deleted device Id.

### Example 7: Get deleted device by DeviceId

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeletedDevice -Filter "deviceId eq 'bbbbbbbb-1111-2222-3333-cccccccccccc'"
```

```Output
DeletedDateTime         Id                                   AccountEnabled ApproximateLastSignInDateTime DeviceId                             DisplayName
---------------         --                                   -------------- ----------------------------- --------                             ------
10/28/2024 4:16:02 PM  cccccccc-2222-3333-4444-dddddddddddd True           6/24/2024 8:00:39 PM          bbbbbbbb-1111-2222-3333-cccccccccccc Woodgrove Desktop
```

This cmdlet retrieves the deleted device specified by DeviceId.

- `-DeviceId` parameter specifies the deleted device Id.

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

### -Filter

Retrieve only those deleted devices that satisfy the filter.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Retrieve only those devices that satisfy the -SearchString value.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

The maximum number of devices.

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

Specifies properties to be returned

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

### -DeviceObjectId

The unique ID of the deleted device to be retrieved.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraDevice](Get-EntraDevice.md)
