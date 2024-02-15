---
title: Get-EntraBetaGroupMember.
description: This article provides details on the Get-EntraBetaGroupMember command.

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

# Get-EntraBetaGroupMember

## SYNOPSIS
Gets a member of a group.

## SYNTAX

```
Get-EntraBetaGroupMember 
 -ObjectId <String> 
 [-Top <Int32>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaGroupMember cmdlet gets a member of a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a group member by ID
```
PS C:\>EntraBetaGroupMember -ObjectId 05b0552e-39cd-4df4-a8f5-00ade912e83d

Id                                   DeletedDateTime
--                                   ---------------
2ae2d97b-4bde-42aa-b7c0-7c91a4c91a77
```
This command gets a member of a specified group.

### Example 2: Get two group member
```
PS C:\>EntraBetaGroupMember -ObjectId 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 -Top 2

Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
1554fcc2-9d6e-446b-9e1a-651c9ccfa413
```
This command gets the top two group members.

### Example 3: Get all members within a group by group ID
```
PS C:\>EntraBetaGroupMember -ObjectId 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 -All $true

Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
1554fcc2-9d6e-446b-9e1a-651c9ccfa413
e19c5875-9f67-4634-9af7-8e544aa76765
142bffc9-e10c-4ea0-ac17-bee0ac7468fd
2ae2d97b-4bde-42aa-b7c0-7c91a4c91a77
4a18c37a-a83d-489d-a35c-fdad407cd734
```
This command gets all members within a Group.

## PARAMETERS

### -All
If true, return all group members.
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

### -ObjectId
Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaGroupMember]()

[Remove-EntraBetaGroupMember]()

