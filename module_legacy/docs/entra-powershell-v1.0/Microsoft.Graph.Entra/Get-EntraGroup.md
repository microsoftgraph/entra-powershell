---
title: Get-EntraGroup
description: This article explains the Get-EntraGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraGroup

schema: 2.0.0
---

# Get-EntraGroup

## Synopsis

Gets a group.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraGroup
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraGroup
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraGroup
 -GroupId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraGroup` cmdlet gets a group in Microsoft Entra ID. Specify the `ObjectId` parameter to get a specific group.

## Examples

### Example 1: Get all groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup
```

```Output
DisplayName                                       Id                                   MailNickname                                   Description
-----------                                       --                                   ------------                                   -----------
SimpleTestGrp                                     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb NickName
SimpleGroup                                       bbbbbbbb-1111-2222-3333-cccccccccccc NickName
testGroupInAU10                                   cccccccc-2222-3333-4444-dddddddddddd testGroupInAU10                                testGroupInAU10
My new group                                      dddddddd-3333-4444-5555-eeeeeeeeeeee NotSet                                         New created group
SimpleGroup                                       eeeeeeee-4444-5555-6666-ffffffffffff NickName
```

This example demonstrates how to get all groups from Microsoft Entra ID.

### Example 2: Get a specific group by using an GroupId

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -GroupId 'pppppppp-4444-0000-8888-yyyyyyyyyyyy'
```

```Output
DisplayName    Id                                   MailNickname        Description         GroupTypes
-----------    --                                   ------------        -----------         ----------
Crimson Eagle  pppppppp-4444-0000-8888-yyyyyyyyyyyy crimsoneaglegroup   Crimson Eagle Group {Unified}
```

This example demonstrates how to retrieve specific group by providing ID.

### Example 3: Get top five groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -Top 5
```

```Output
DisplayName             Id                                   MailNickname          Description
-----------             --                                   ------------          -----------
Contoso Group           hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq contosogroup          Contoso Group
Crimson Eagle           pppppppp-4444-0000-8888-yyyyyyyyyyyy crimsoneagle          Crimson Eagle Group
Bold Falcon             tttttttt-0000-3333-9999-mmmmmmmmmmmm boldfalcon            Bold Falcon Group
Azure Panda             qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh azurepanda            Azure Panda
Misty Fox               kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn mistyfox              Misty Fox Group
```

This example demonstrates how to get top five groups.

### Example 4: Get a group by DisplayName

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -Filter "DisplayName eq 'Azure Panda'"
```

```Output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Azure Panda        qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh azurepanda       Azure Panda        {Unified}
```

In this example, we retrieve group using the Display Name.

### Example 5: Get groups that contain a search string

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -SearchString 'New'
```

```Output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Sparkling Deer      bbbbbbbb-5555-5555-0000-qqqqqqqqqqqq newsparklingdeer New Sparkling Deer Group {Unified}
New Golden Fox          xxxxxxxx-8888-5555-9999-bbbbbbbbbbbb newgoldenfox                  New Golden Fox            {DynamicMembership}
```

This example demonstrates how to retrieve groups that include the text new in their display names from Microsoft Entra ID.

### Example 6: Listing ownerless groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$allGroups = Get-EntraGroup -All
$groupsWithoutOwners = foreach ($group in $allGroups) {
    $owners = Get-EntraGroupOwner -ObjectId $group.Id
    if ($owners.Count -eq 0) {
        $group
    }
}
$groupsWithoutOwners | Format-Table DisplayName, Id, GroupTypes
```

```Output
DisplayName           Id                                   GroupTypes
-----------           --                                   ----------
My new group          aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {}
HelpDesk admin group  eeeeeeee-4444-5555-6666-ffffffffffff {}
```

This example demonstrates how to retrieve groups without owners. By identifying ownerless groups, IT admins can improve overall governance and operational efficiency.

### Example 7: Listing empty groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$allGroups = Get-EntraGroup -All
$groupsWithoutMembers = foreach ($group in $allGroups) {
    $members = Get-EntraGroupMember -ObjectId $group.Id
    if ($members.Count -eq 0) {
        $group
    }
}
$groupsWithoutMembers | Format-Table DisplayName, Id, GroupTypes
```

```Output
DisplayName           Id                                   GroupTypes
-----------           --                                   ----------
My new group          aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {}
HelpDesk admin group  eeeeeeee-4444-5555-6666-ffffffffffff {}
```

This example demonstrates how to retrieve groups without members. By identifying memberless groups, IT admins can identify and clean up unused or obsolete groups that no longer serve a purpose.

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

The unique identifier of a group in Microsoft Entra ID (GroupId)

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

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
Parameter Sets: GetValue
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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
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

[New-EntraGroup](New-EntraGroup.md)

[Remove-EntraGroup](Remove-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)
