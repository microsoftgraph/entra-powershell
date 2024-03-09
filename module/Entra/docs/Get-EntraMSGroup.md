---
title: Get-EntraMSGroup.
description: This article provides details on the Get-EntraMSGroup command.

ms.service: active-directory
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
```
Get-EntraMSGroup 
 [-Top <Int32>] 
 [-All <Boolean>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetByValue
```
Get-EntraMSGroup 
 [-SearchString <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

### GetById
```
Get-EntraMSGroup 
 -Id <String> 
[-All <Boolean>] 
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSGroup cmdlet gets information about groups in Microsoft Entra ID.
To get a group, specify the ID parameter. 
Specify the SearchString or Filter parameter finds particular groups. 
If you specify no parameters, this cmdlet gets all groups.

## EXAMPLES

### Example 1: Get all groups
```powershell
PS C:\> Get-EntraMSGroup
```
```output
DisplayName                         Id                                   MailNickname                     Description
-----------                         --                                   ------------                     -----------
Ask HR                              056b2531-005e-4f3e-be78-01a71ea30a04 askhr
Parents of Contoso                  05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso                 Parents of Contoso
Contoso Team                        0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam                      A collaboration area for the Contoso Team.
HelpDesk admin group                0883fd77-0ee8-45de-a21e-f32af1623acc helpDeskAdminGroup               Group assignable to role
New Employee Onboarding             0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding            New Employee Onboarding
HelpDesk admin group3               0bdddeb1-88a6-4251-aaa5-98b48271158b helpDeskAdminGroup               group des

```

This example demonstrates how to retrieve all groups from Microsoft Entra ID. 

### Example 2: Get a specific group by using an ID
```powershell
PS C:\> Get-EntraMSGroup -Id "0877c6c6-fc99-4d51-9871-8335be7cfc9d"
```
```output
DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Contoso Team 0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam  A collaboration area for the Contoso Team. {Unified}
```

In this example, provide the ID to retrieve a specific group. 

### Example 3: Get top five groups
```powershell
PS C:\> Get-EntraMSGroup -Top 5
```
```output
DisplayName             Id                                   MailNickname          Description                                GroupTypes
-----------             --                                   ------------          -----------                                ----------
Ask HR                  056b2531-005e-4f3e-be78-01a71ea30a04 askhr                                                            {Unified}
Parents of Contoso      05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso      Parents of Contoso                         {Unified}
Contoso Team            0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam           A collaboration area for the Contoso Team. {Unified}
HelpDesk admin group    0883fd77-0ee8-45de-a21e-f32af1623acc helpDeskAdminGroup    Group assignable to role                   {}
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding                    {Unified}
```

This example demonstrates how to retrieve top five groups from Microsoft Entra ID. 

### Example 4: Get a group by DisplayName
```powershell
PS C:\> Get-EntraMSGroup -Filter "DisplayName eq 'Parents of Contoso'"
```
```output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Parents of Contoso 05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso Parents of Contoso {Unified}
```

This example demonstrates how to retrieve a group using the DisplayName. 

### Example 5: Search among retrieved groups
```powershell
PS C:\> Get-EntraMSGroup -SearchString "New"
```
```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding {Unified}
new1                    27d134ad-466b-43dd-8856-ba9f0bc17d24 new1                  new1                    {DynamicMembership, Unified}
```

This example demonstrates how to retrieve groups using SearchString against the first characters in DisplayName or Description attributes.

## PARAMETERS

### -All
If true, return all groups.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
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
Type: String
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
Type: String
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
Type: String
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
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## RELATED LINKS

[New-EntraMSGroup](New-EntraMSGroup.md)

[Remove-EntraMSGroup](Remove-EntraMSGroup.md)

[Set-EntraMSGroup](Set-EntraMSGroup.md)