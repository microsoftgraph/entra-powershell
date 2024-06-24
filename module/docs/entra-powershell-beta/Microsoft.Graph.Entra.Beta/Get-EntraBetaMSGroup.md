---
title: Get-EntraBetaMSGroup.
description: This article provides details on the Get-EntraBetaMSGroup command.

ms.service: entra
ms.topic: reference
ms.date: 06/18/2023
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
```powershell
Get-EntraBetaMSGroup 
 [-Select <String>] 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaMSGroup 
 -Id <String> 
 [-Select <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraBetaMSGroup 
 [-All] 
 [-SearchString <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-EntraBetaMSGroup` cmdlet gets information about groups in Microsoft Entra ID.
Specify the `Id` parameter to get a specific group.
Specify the SearchString or Filter parameter and find particular groups. 
If you specify no parameters, this cmdlet gets all groups.

## EXAMPLES

### Example 1: Get all groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup
```
```output

DisplayName                         Id                                   MailNickname                     Description
-----------                         --                                   ------------                     -----------
Ask HR                              eeeeeeee-4444-5555-6666-ffffffffffff askhr
Parents of Contoso                  ffffffff-5555-6666-7777-aaaaaaaaaaaa parentsofcontoso                 Parents of Contoso
Contoso Team                        aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb contosoteam                      A collaboration area for the Contoso Team.
HelpDesk admin group                bbbbbbbb-7777-8888-9999-cccccccccccc helpDeskAdminGroup               Group assignable to role
New Employee Onboarding             cccccccc-8888-9999-0000-dddddddddddd newemployeeonboarding            New Employee Onboarding
HelpDesk admin group3               dddddddd-9999-0000-1111-eeeeeeeeeeee helpDeskAdminGroup               group des

```

This command gets all groups in Microsoft Entra ID.

### Example 2: Get a specific group by using an ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -Id 'dddddddd-9999-0000-1111-eeeeeeeeeeee'
```
```output

DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Contoso Team dddddddd-9999-0000-1111-eeeeeeeeeeee contosoteam  A collaboration area for the Contoso Team. {Unified}

```

In this example, we provide the ID to retrieve a specific group.

### Example 3: Get top five groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -Top 5
```
```output

DisplayName             Id                                   MailNickname          Description                                GroupTypes
-----------             --                                   ------------          -----------                                ----------
Ask HR                  dddddddd-9999-0000-1111-eeeeeeeeeeee askhr                                                            {Unified}
Parents of Contoso      cccccccc-8888-9999-0000-dddddddddddd parentsofcontoso      Parents of Contoso                         {Unified}
Contoso Team            ffffffff-5555-6666-7777-aaaaaaaaaaaa contosoteam           A collaboration area for the Contoso Team. {Unified}
HelpDesk admin group    cccccccc-2222-3333-4444-dddddddddddd helpDeskAdminGroup    Group assignable to role                   {}
New Employee Onboarding bbbbbbbb-1111-2222-3333-cccccccccccc newemployeeonboarding New Employee Onboarding                    {Unified}
```

This example demonstrates how to retrieve top five groups from Microsoft Entra ID.


### Example 4: Get a group by DisplayName


```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -Filter "DisplayName eq 'Parents of Contoso'"
```
```output

DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Parents of Contoso bbbbbbbb-1111-2222-3333-cccccccccccc parentsofcontoso Parents of Contoso {Unified}
```
This example retrieves group by DisplayName.

### Example 5: Search among retrieved groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -SearchString 'New'
```
```output

DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding eeeeeeee-4444-5555-6666-ffffffffffff newemployeeonboarding New Employee Onboarding {Unified}
new1                    bbbbbbbb-1111-2222-3333-cccccccccccc new1                  new1                    {DynamicMembership, Unified}
```

This example demonstrates how to retrieve groups using  SearchString against the first characters in DisplayName or Description attributes.


### Example 6: Get AssignedLabels and DisplayName property values for all groups

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -Select 'AssignedLabels,DisplayName'
```
```output
 
DisplayName                         Id MailNickname Description GroupTypes
-----------                         -- ------------ ----------- ----------
Ask HR
Parents of Contoso
Contoso Team
HelpDesk admin group
New Employee Onboarding
HelpDesk admin group3
testGroupInAU10
Parents of Conto
```

This example demonstrates how to retrieve AssignedLabels and DisplayName property values for all groups.

AssignedLabels group property retrieved only by Select parameter.

### Example 7: Get DisplayName, ID, and Description property values for a group

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaMSGroup -Id 'eeeeeeee-4444-5555-6666-ffffffffffff' -Select 'DisplayName,Id,Description'
```
```output

DisplayName  Id                                   MailNickname Description                                GroupTypes
-----------  --                                   ------------ -----------                                ----------
Contoso Team eeeeeeee-4444-5555-6666-ffffffffffff              A collaboration area for the Contoso Team.
```

This example gets DisplayName, ID, and Description property values for a specific group.

AssignedLabels group property retrieved only by Select parameter.

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

### -Select
Specifies a list of group properties to retrieve.

```yaml
Type: System.String
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
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ID
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
Parameter Sets: GetValue
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
This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES
This cmdlet is currently in Public Preview.
While a cmdlet is in Public Preview, we might make changes to the cmdlet, which could have unexpected effects.
We recommend that you don't use this cmdlet in a production environment.

## RELATED LINKS

[New-EntraBetaMSGroup](New-EntraBetaMSGroup.md)

[Remove-EntraBetaMSGroup](Remove-EntraBetaMSGroup.md)

[Set-EntraBetaMSGroup](Set-EntraBetaMSGroup.md)

[#Microsoft Entra ID: Certificate based authentication for iOS and Android now in preview!](https://blogs.technet.microsoft.com/enterprisemobility/2016/07/18/azuread-certificate-based-authentication-for-ios-and-android-now-in-preview/)