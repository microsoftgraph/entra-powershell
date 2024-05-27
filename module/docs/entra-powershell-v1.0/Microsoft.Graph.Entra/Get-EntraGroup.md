---
title: Get-EntraGroup.
description: This article explains the Get-EntraGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi254
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraGroup

## SYNOPSIS

Gets a group.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraGroup
 [-Top <Int32>]
 [-All <Boolean>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraGroup
 [-SearchString <String>]
 [-All <Boolean>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraGroup
 -ObjectId <String>
 [-All <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraGroup cmdlet gets a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get all groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup
```

```output
ObjectId                             DisplayName                          Description
--------                             -----------                          -----------
00000000-0000-0000-0000-000000000000  Contoso Group                       Contoso Group
11111111-1111-1111-1111-111111111111  Crimson Eagle                       Crimson Eagle Group
22222222-2222-2222-2222-222222222222  Bold Falcon                         Bold Falcon Group
```

This example demonstrates how to get all groups from Microsoft Entra ID.

### Example 2: Get a specific group by using an ObjectId

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -ObjectId '11111111-1111-1111-1111-111111111111'
```

```output
DisplayName    Id                                   MailNickname        Description         GroupTypes
-----------    --                                   ------------        -----------         ----------
Crimson Eagle  11111111-1111-1111-1111-111111111111 crimsoneaglegroup   Crimson Eagle Group {Unified}
```

This example demonstrates how to retrieve specific group by providing ID.  
This command gets information for the group that has the specified ID.

### Example 3: Get top five groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -Top 5
```

```output
DisplayName             Id                                   MailNickname          Description
-----------             --                                   ------------          -----------
Contoso Group           00000000-0000-0000-0000-000000000000 contosogroup          Contoso Group
Crimson Eagle           11111111-1111-1111-1111-111111111111 crimsoneagle          Crimson Eagle Group
Bold Falcon             22222222-2222-2222-2222-222222222222 boldfalcon            Bold Falcon Group
Azure Panda             33333333-3333-3333-3333-333333333333 azurepanda            Azure Panda
Misty Fox               44444444-4444-4444-4444-444444444444 mistyfox              Misty Fox Group
```

This example demonstrates how to get top five groups from Microsoft Entra ID.  
This command gets the five groups in Microsoft Entra ID.

### Example 4: Get a group by DisplayName

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -Filter "DisplayName eq 'Azure Panda'"
```

```output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Azure Panda        33333333-3333-3333-3333-333333333333 azurepanda       Azure Panda        {Unified}
```

In this example, we retrieve group by display name from Microsoft Entra ID.
This command gets the specified group.

### Example 5: Get groups that contain a search string

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroup -SearchString 'New'
```

```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Sparkling Deer      66666666-6666-6666-6666-666666666666 newemployeeonboarding New Sparkling Deer Group {Unified}
New Golden Fox          77777777-7777-7777-7777-777777777777 new1                  newgoldenfox            {DynamicMembership}
```

This example demonstrates how to retrieve groups that include the text new in their display names from Microsoft Entra ID.

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

### -ObjectId

The unique identifier of a group in Microsoft Entra ID (ObjectId)

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraGroup](New-EntraGroup.md)

[Remove-EntraGroup](Remove-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)
