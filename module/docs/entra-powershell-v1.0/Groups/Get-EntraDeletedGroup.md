---
description: This article provides details on the Get-EntraDeletedGroup command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedGroup
schema: 2.0.0
title: Get-EntraDeletedGroup
---

# Get-EntraDeletedGroup

## SYNOPSIS

Retrieves soft-deleted groups in Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraDeletedGroup
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraDeletedGroup
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDeletedGroup
 -GroupId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDeletedGroup
 [-All]
 [-SearchString <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDeletedGroup` cmdlet retrieves soft-deleted groups from the directory. Deleted groups can be recovered within 30 days, after which they are permanently deleted.

Soft delete currently applies only to Unified Groups (Office 365 Groups).

## EXAMPLES

### Example 1: Get deleted groups in the directory

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves all recoverable deleted groups in the Microsoft Entra ID.

### Example 2: Get deleted groups in the directory using All parameter

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup -All | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves all recoverable deleted groups in the directory, using All parameter.

### Example 3: Get top two deleted groups

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup -Top 2 | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves top two deleted groups in the directory. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted groups containing string 'test2'

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup -SearchString 'Contoso Group' | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves deleted groups in the directory, containing the specified string.

### Example 5: Get deleted groups filter by display name

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup -Filter "displayName eq 'Contoso Group'" | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves deleted groups in the directory, having the specified display name.

### Example 6: Get deleted group by GroupId

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraDeletedGroup -GroupId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' | Select-Object Id, DisplayName, MailNickname, GroupTypes, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName    MailNickname GroupTypes DeletedDateTime       DeletionAgeInDays
--                                   -----------    ------------ ---------- ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Group contosogroup {Unified}  2/12/2025 12:34:13 PM                 10
```

This cmdlet retrieves the deleted group specified by GroupId.

- `-GroupId` parameter specifies the deleted group GroupId.

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

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

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

### -GroupId

The GroupId of the deleted group to be retrieved.

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

### -SearchString

Specifies a search string.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
