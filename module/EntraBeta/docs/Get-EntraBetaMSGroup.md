---
title: Get-EntraBetaMSGroup.
description: This article provides details on the Get-EntraBetaMSGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSGroup

## SYNOPSIS
Gets information about groups in Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSGroup 
 [-Select <String>] 
 [-Filter <String>] 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSGroup 
 -Id <String> 
 [-Select <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

### GetValue
```
Get-EntraBetaMSGroup 
 [-All <Boolean>] 
 [-SearchString <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSGroup cmdlet gets information about groups in Microsoft Entra ID.
To get a group, specify the Id parameter. 
Specify the SearchString or Filter parameter to find particular groups. 
If you specify no parameters, this cmdlet gets all groups.

## EXAMPLES

### Example 1: Get all groups
```
PS C:\> Get-EntraBetaMSGroup

```

This command gets all groups in Microsoft Entra ID.

### Example 2: Get a specific group by using an ID
```
PS C:\> Get-EntraBetaMSGroup -Id "0877c6c6-fc99-4d51-9871-8335be7cfc9d"

DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Contoso Team 0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam  A collaboration area for the Contoso Team. {Unified}
```

This command gets information for the group that has the specified ID.

### Example 3: Get top five groups
```
PS C:\> Get-EntraBetaMSGroup -Top 5

DisplayName             Id                                   MailNickname          Description                                GroupTypes
-----------             --                                   ------------          -----------                                ----------
Ask HR                  056b2531-005e-4f3e-be78-01a71ea30a04 askhr                                                            {Unified}
Parents of Contoso      05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso      Parents of Contoso                         {Unified}
Contoso Team            0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam           A collaboration area for the Contoso Team. {Unified}
HelpDesk admin group    0883fd77-0ee8-45de-a21e-f32af1623acc helpDeskAdminGroup    Group assignable to role                   {}
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding                    {Unified}
```

This command gets the top five groups in Microsoft Entra ID.

### Example 4: Get a group by DisplayName
```
PS C:\> Get-EntraBetaMSGroup -Filter "DisplayName eq 'Parents of Contoso'"

DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Parents of Contoso 05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso Parents of Contoso {Unified}
```

This command gets the specified group.

### Example 5: Search among retrieved groups
```
PS C:\> Get-EntraBetaMSGroup -SearchString "New"

DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding {Unified}
new1                    27d134ad-466b-43dd-8856-ba9f0bc17d24 new1                  new1                    {DynamicMembership, Unified}
```

This cmdlet gets all groups that match the value of SearchString against the first characters in DisplayName or Description attributes.

### Example 6: Get AssignedLabels and DisplayName property values for all groups
```
PS C:\> Get-EntraBetaMSGroup -Select "AssignedLabels,DisplayName"

```

This command gets AssignedLabels and DisplayName property values for all groups.

AssignedLabels group property could be retrieved only by Select parameter.

### Example 7: Get DisplayName, Id and Description property values for a group
```
PS C:\> Get-EntraBetaMSGroup -Id "0877c6c6-fc99-4d51-9871-8335be7cfc9d" -Select "DisplayName,Id,Description"

DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Contoso Team 0877c6c6-fc99-4d51-9871-8335be7cfc9d              A collaboration area for the Contoso Team.
```

This command gets DisplayName, Id and Discription property values for a specific group.

AssignedLabels group property could be retrieved only by Select parameter.

## PARAMETERS

### -All
If true, return all groups.
If false, return the number of objects specified by the Top parameter

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

### -Select
Specifies a list of group properties to retrieve.

```yaml
Type: String
Parameter Sets: GetQuery, GetById
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
Specifies the maximum number of records that this cmldet gets.
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
## NOTES
This cmdlet is currently in Public Preview.
While a cmdlet is in Public Preview, we may make changes to the cmdlet which could have unexpected effects.
We recommend that you do not use this cmdlet in a production environment.

## RELATED LINKS

[New-EntraBetaMSGroup]()

[Remove-EntraBetaMSGroup]()

[Set-EntraBetaMSGroup]()

[#Microsoft Entra ID: Certificate based authentication for iOS and Android now in preview!](https://blogs.technet.microsoft.com/enterprisemobility/2016/07/18/azuread-certificate-based-authentication-for-ios-and-android-now-in-preview/)

