---
title: Get-EntraMSDeletedGroup
description: This article provides details on the Get-EntraMSDeletedGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSDeletedGroup

## Synopsis

This cmdlet is used to retrieve the soft deleted groups in a directory.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraMSDeletedGroup 
 [-Top <Int32>] 
 [-All] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraMSDeletedGroup 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSDeletedGroup 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

This cmdlet is used to retrieve the soft deleted groups in a directory.
When a group is deleted, it's initially soft deleted and can be recovered during the first 30 days after deletion.
After 30 days the group is permanently deleted and can no longer be recovered.
Soft delete is currently only implemented for Unified Groups (also known as
Office 365 Groups).

## Examples

### Example 1: Get deleted groups in the directory

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
test22      bbbbbbbb-1111-2222-3333-cccccccccccc test22       desc2       {Unified, DynamicMembership}
test23      cccccccc-2222-3333-4444-dddddddddddd test23       desc3       {Unified, DynamicMembership}
test24      dddddddd-3333-4444-5555-eeeeeeeeeeee test24       desc4       {Unified, DynamicMembership}
```

This cmdlet retrieves all recoverable deleted groups in the directory.  

### Example 2: Get deleted groups in the directory using All parameter

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup -All 
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
test22      bbbbbbbb-1111-2222-3333-cccccccccccc test22       desc2       {Unified, DynamicMembership}
test23      cccccccc-2222-3333-4444-dddddddddddd test23       desc3       {Unified, DynamicMembership}
test24      dddddddd-3333-4444-5555-eeeeeeeeeeee test24       desc4       {Unified, DynamicMembership}
```

This cmdlet retrieves all recoverable deleted groups in the directory, using All parameter.  

### Example 3: Get top two deleted groups

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup -Top 2
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
test22      bbbbbbbb-1111-2222-3333-cccccccccccc test22       desc2       {Unified, DynamicMembership}
```

This cmdlet retrieves top two deleted groups in the directory.  

### Example 4: Get deleted groups containing string 'test2'

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup -SearchString 'test2'
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
test22      bbbbbbbb-1111-2222-3333-cccccccccccc test22       desc2       {Unified, DynamicMembership}
test23      cccccccc-2222-3333-4444-dddddddddddd test23       desc3       {Unified, DynamicMembership}
test24      dddddddd-3333-4444-5555-eeeeeeeeeeee test24       desc4       {Unified, DynamicMembership}
```

This cmdlet retrieves deleted groups in the directory, containing the specified string.  

### Example 5: Get deleted groups filter by display name

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup -Filter "displayname eq 'test21'"
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
```

This cmdlet retrieves deleted groups in the directory, having the specified display name.  

### Example 6: Get deleted group by Id

```powershell
Connect-Entra -Scopes 'Group.Read.All'
Get-EntraMSDeletedGroup -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
test21      aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb test21       desc1       {Unified, DynamicMembership}
```

This cmdlet retrieves the deleted group specified by `-Id`.  

## Parameters

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

Specifies an oData v3.0 filter statement.
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

### -Id

The Id of the deleted group to be retrieved.

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
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related LINKS
