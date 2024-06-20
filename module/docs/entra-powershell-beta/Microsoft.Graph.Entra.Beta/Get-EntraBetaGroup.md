---
title: Get-EntraBetaGroup.
description: This article provides details on the Get-EntraBetaGroup command.

ms.service: entra
ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroup

## SYNOPSIS
Gets a group.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraBetaGroup 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraBetaGroup 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaGroup 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-EntraBetaGroup` cmdlet gets a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get all groups
```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroup
```
```output

DisplayName                                       Id                                   MailNickname                                   Description
-----------                                       --                                   ------------                                   -----------
SimpleTestGrp                                     00a460df-1b24-41db-a2d8-4eb8cd82e4a1 NickName
SimpleGroupc13adf68-dffb-4185-a94f-e81bda906aa5   01c9ea6e-c28e-4d3a-a5e7-e90af9300499 NickName
testGroupInAU10                                   02af6904-3630-4074-bbcb-8e0ed04a40ce testGroupInAU10                                testGroupInAU10
My new group                                      040e1190-daac-41ce-b26d-b2e79a9dd8b4 NotSet                                         New created group
SimpleGroupaeaea4bd-30df-4e13-b318-b416ed4e9357   0590f8df-dfbf-4892-bf45-f23069d6ed71 NickName
```

This example demonstrates how to get all groups from Microsoft Entra ID.  

### Example 2: Get a specific group by using an ObjectId
```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroup -ObjectId "1d7f20aa-bbcd-4822-ab28-092015b90692"
```
```output
DisplayName                                       Id                                   MailNickname Description GroupTypes
-----------                                       --                                   ------------ ----------- ----------
SimpleTestGrpbcd1865e-c8b9-4f90-8943-77607ef15590 1d7f20aa-bbcd-4822-ab28-092015b90692 NickName                 {}
```

This example demonstrates how to retrieve specific group by providing ID. Specify the `ObjectId` parameter to get a specific group. 
This command gets information for the group that has the specified ID.

### Example 3: Get top five groups 
```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroup -Top 5
```
```output
DisplayName                                     Id                                   MailNickname       Description              GroupTypes
-----------                                     --                                   ------------       -----------              ----------
SimpleTestGrp                                   00a460df-1b24-41db-a2d8-4eb8cd82e4a1 NickName                                    {}
SimpleGroupc13adf68-dffb-4185-a94f-e81bda906aa5 01c9ea6e-c28e-4d3a-a5e7-e90af9300499 NickName                                    {}
testGroupInAU10                                 02af6904-3630-4074-bbcb-8e0ed04a40ce testGroupInAU10    testGroupInAU10          {DynamicMembership, Unified}
SimpleGroupaeaea4bd-30df-4e13-b318-b416ed4e9357 0590f8df-dfbf-4892-bf45-f23069d6ed71 NickName                                    {}
HelpDesk admin group                            0883fd77-0ee8-45de-a21e-f32af1623acc helpDeskAdminGroup Group assignable to role {}
```

This example demonstrates how to get top five groups from Microsoft Entra ID.  
This command gets the five groups in Microsoft Entra ID.

### Example 4: Get a group by DisplayName
```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroup -Filter "DisplayName eq 'Parents of Contoso'"
```
```output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Parents of Contoso 05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso Parents of Contoso {Unified}
```  
In this example, we retrieve group by display name from Microsoft Entra ID.    
This command gets the specified group.

### Example 5: Get groups that contain a search string
```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroup -SearchString "New"
```
```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding {Unified}
new1                    27d134ad-466b-43dd-8856-ba9f0bc17d24 new1                  new1                    {DynamicM...
```

This example demonstrates how to retrieve groups that include the text new in their display names from Microsoft Entra ID.

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
The unique identifier of a group in Microsoft Entra ID. (ObjectId)

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

### CommonParameters
This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaGroup](New-EntraBetaGroup.md)

[Remove-EntraBetaGroup](Remove-EntraBetaGroup.md)

[Set-EntraBetaGroup](Set-EntraBetaGroup.md)