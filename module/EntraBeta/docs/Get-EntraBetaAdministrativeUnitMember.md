---
title: Get-EntraBetaAdministrativeUnitMember.
description: This article provides details on the Get-EntraBetaAdministrativeUnitMember command.

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

# Get-EntraBetaAdministrativeUnitMember

## SYNOPSIS
Gets a member of an administrative unit.

## SYNTAX

```
Get-EntraBetaAdministrativeUnitMember 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>]
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaAdministrativeUnitMember cmdlet gets a member of an Microsoft Entra ID administrative unit.

## EXAMPLES

### Example 1: Get an administrative unit member by ID
```
PS C:\> Get-EntraBetaAdministrativeUnitMember -ObjectId "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"

Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
a23541ee-4fe9-4cf2-b628-102ebaef8f7e
fd560167-ff1f-471a-8d74-3b0070abcea1
```

This command gets the administrative unit member for specified ObjectId.


### Example 2: Get all administrative unit members 
```
PS C:\> Get-EntraBetaAdministrativeUnitMember -ObjectId "3da073b9-e731-4ec1-a4f6-6e02865a8c8a" -All $true

Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
a23541ee-4fe9-4cf2-b628-102ebaef8f7e
fd560167-ff1f-471a-8d74-3b0070abcea1
```

This command gets the all administrative unit members for specified ObjectId.

### Example 3: Get two administrative unit members 
```
PS C:\> Get-EntraBetaAdministrativeUnitMember -ObjectId "3da073b9-e731-4ec1-a4f6-6e02865a8c8a" -Top 2

Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
a23541ee-4fe9-4cf2-b628-102ebaef8f7e
```

This command gets the top two administrative unit members for specified ObjectId.


## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are: * Continue

* Ignore
* Inquire
* SilentlyContinue
* Stop
* Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies a variable in which to store an information event message.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of an administrative unit in Microsoft Entra ID.

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

### -All
If true, return all administrative unit members.
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

[Add-EntraBetaAdministrativeUnitMember]()

[Remove-EntraBetaAdministrativeUnitMember]()

