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
PS C:\>Connect-Entra -Scopes 'GroupMember.Read.All'
PS C:\>Get-EntraGroup
```

```output
ObjectId                             DisplayName                          Description
--------                             -----------                          -----------
xxxx-xxxx-xxxx-xxxx    Contoso Group                 Contoso Group
yyyy-yyyy-yyyy-yyyy Crimson Eagle    Crimson Eagle Group
aaaa-aaaa-aaaa-aaaa Bold Falcon                Bold Falcon Group
```

This example demonstrates how to get all groups from Microsoft Entra ID.

### Example 2: Get a specific group by using an ObjectId

```powershell
PS C:\>Connect-Entra -Scopes 'GroupMember.Read.All'
PS C:\>Get-EntraGroup -ObjectId 'aaaa-aaaa-aaaa-aaaa'
```

```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
Demo Group One   aaaa-aaaa-aaaa-aaaa demogroupone Demo Group One        {Unified}
```

This example demonstrates how to retrieve specific group by providing ID.  
This command gets information for the group that has the specified ID.

### Example 3: Get top five groups

```powershell
PS C:\>Connect-Entra -Scopes 'GroupMember.Read.All'
PS C:\>Get-EntraGroup -Top 5
```

```output
DisplayName             Id                                   MailNickname          Description
-----------             --                                   ------------          -----------
Demo Group One                cccc-cccc-cccc-cccc demogroupone    Demo Group One
Demo Group Two      eeee-eeee-eeee-eeee demogrouptwo      Demo Group Two
Demo Group Three            gggg-gggg-gggg-gggg demogroupthree    Demo Group Three
Demo Group Four    bbbb-bbbb-bbbb-bbbb demogroupfour    Demo Group Four
Demo Group Five yyyy-yyyy-yyyy-yyyy demogroupfive Demo Group Five
```

This example demonstrates how to get top five groups from Microsoft Entra ID.  
This command gets the five groups in Microsoft Entra ID.

### Example 4: Get a group by DisplayName

```powershell
PS C:\>Connect-Entra -Scopes 'GroupMember.Read.All'
PS C:\>Get-EntraGroup -Filter "DisplayName eq 'Contoso Demo'"
```

```output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Contoso Demo bbbb-bbbb-bbbb-bbbb contosodemo Contoso Demo Group {Unified}
```

In this example, we retrieve group by display name from Microsoft Entra ID.
This command gets the specified group.

### Example 5: Get groups that contain a search string

```powershell
PS C:\>Connect-Entra -Scopes 'GroupMember.Read.All'
PS C:\>Get-EntraGroup -SearchString 'New'
```

```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Sparkling Deer yyyy-yyyy-yyyy-yyyy newemployeeonboarding New Sparkling Deer Group {Unified}
New Golden Fox                    aaaa-aaaa-aaaa-aaaa new1                  newgoldenfox                    {DynamicM...
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
