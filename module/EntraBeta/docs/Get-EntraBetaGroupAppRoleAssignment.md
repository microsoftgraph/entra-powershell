---
title: Get-EntraBetaGroupAppRoleAssignment
description: This article provides details on the Get-EntraBetaGroupAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupAppRoleAssignment

## SYNOPSIS
Gets a group application role assignment.

## SYNTAX

```
Get-EntraBetaGroupAppRoleAssignment -ObjectId <String> [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaGroupAppRoleAssignment cmdlet gets a group application role assignment in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve application role assignments of a group
```
$GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
Get-EntraBetaGroupAppRoleAssignment -ObjectId $GroupId

ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE M365 License Manager                Ask HR
```

The first command gets the object ID of a group by using the Get-EntraBetaGroup (./Get-EntraBetaGroup.md)cmdlet.
The command stores the ID in the $GroupId variable.

The second command gets the application role assignments of the group in $GroupId.

### Example 2: Retrieve all application role assignments of a group
```
$GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
Get-EntraBetaGroupAppRoleAssignment -ObjectId $GroupId -All $true

ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE M365 License Manager                Ask HR
```

### Example 3: Retrieve top 2 application role assignments of a group
```
$GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
Get-EntraBetaGroupAppRoleAssignment -ObjectId $GroupId -Top 2

ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
```

## PARAMETERS

### -All
If true, return all application role assignments.
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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

[New-EntraBetaGroupAppRoleAssignment](New-EntraBetaGroupAppRoleAssignment.md)

[Remove-EntraBetaGroupAppRoleAssignment](Remove-EntraBetaGroupAppRoleAssignment.md)

