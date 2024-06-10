---
title: Get-EntraMSGroup.
description: This article provides details on the Get-EntraMSGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSGroup

## SYNOPSIS

Gets information about groups in Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraMSGroup 
 [-Top <Int32>] 
 [-All <Boolean>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraMSGroup 
 [-SearchString <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSGroup 
 -Id <String> 
 [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraMSGroup cmdlet gets information about groups in Microsoft Entra ID.
To get a group, specify the ID parameter.
Specify the SearchString or Filter parameter and find particular groups.
If you specify no parameters, this cmdlet gets all groups.

## EXAMPLES

### Example 1: Get all groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraMSGroup
```

```output
DisplayName             Id                                   MailNickname          Description
-----------             --                                   ------------          -----------
Contoso Group           hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq contosogroup          Contoso Group
Crimson Eagle           pppppppp-4444-0000-8888-yyyyyyyyyyyy crimsoneagle          Crimson Eagle Group
Bold Falcon             tttttttt-0000-3333-9999-mmmmmmmmmmmm boldfalcon            Bold Falcon Group
Azure Panda             qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh azurepanda            Azure Panda
Misty Fox               kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn mistyfox              Misty Fox Group
```

This example demonstrates how to retrieve all groups from Microsoft Entra ID.

### Example 2: Get a specific group by using an ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraMSGroup -Id 'tttttttt-0000-3333-9999-mmmmmmmmmmmm'
```

```output
DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Bold Falcon tttttttt-0000-3333-9999-mmmmmmmmmmmm boldfalcon  Bold Falcon Group {Unified}
```

In this example, we'll provide the ID to retrieve a specific group.  

### Example 3: Get top five groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraMSGroup -Top 5
```

```output
DisplayName             Id                                   MailNickname          Description                                GroupTypes
-----------             --                                   ------------          -----------                                ----------
Contoso Group           hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq contosogroup          Contoso Group                             {Unified}
Crimson Eagle           pppppppp-4444-0000-8888-yyyyyyyyyyyy crimsoneagle          Crimson Eagle Group                       {Unified}
Bold Falcon             tttttttt-0000-3333-9999-mmmmmmmmmmmm boldfalcon            Bold Falcon Group                         {Unified}
Azure Panda             qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh azurepanda            Azure Panda                               {}
Misty Fox               kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn mistyfox              Misty Fox Group                           {Unified}
```

This example demonstrates how to retrieve top five groups from Microsoft Entra ID.

### Example 4: Get a group by DisplayName

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraMSGroup -Filter "DisplayName eq 'Azure Panda'"
```

```output
DisplayName             Id                                   MailNickname          Description                                GroupTypes
-----------             --                                   ------------          -----------                                ----------
Azure Panda             qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh azurepanda            Azure Panda                               {}
```

This example demonstrates how to retrieve group by DisplayName.  

### Example 5: Search among retrieved groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraMSGroup -SearchString 'New'
```

```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding dddddddd-3333-6666-8888-eeeeeeeeeeee newemployeeonboarding New Employee Onboarding {Unified}
new1                    ffffffffff-7777-9999-7777-vvvvvvvvvvv new1                  new1                    {DynamicMembership, Unified}
```

This example demonstrates how to retrieve groups using SearchString against the first characters in DisplayName or Description attributes.

## PARAMETERS

### -All

If true, return all groups.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

Specifies an oData v3.0 filter string to match a set of groups.

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

Specifies the ID of the group that this cmdlet gets.

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
This cmdlet gets groups that have DisplayName or Description attributes that match the search string.

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

Specifies the maximum number of records that this cmdlet gets.
The default value is 100.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraMSGroup](New-EntraMSGroup.md)

[Remove-EntraMSGroup](Remove-EntraMSGroup.md)

[Set-EntraMSGroup](Set-EntraMSGroup.md)
