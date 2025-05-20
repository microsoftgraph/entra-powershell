---
title: Get-EntraGroupAppRoleAssignment
description: This article provides details on the Get-EntraGroupAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraGroupAppRoleAssignment

schema: 2.0.0
---

# Get-EntraGroupAppRoleAssignment

## Synopsis

Gets a group application role assignment.

## Syntax

```powershell
Get-EntraGroupAppRoleAssignment
 -GroupId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraGroupAppRoleAssignment` cmdlet gets a group application role assignment in Microsoft Entra ID. Specify the `GroupId` parameter to get a group application role assignment.

## Examples

### Example 1: Retrieve application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$GroupId = (Get-EntraGroup -Top 1).ObjectId
Get-EntraGroupAppRoleAssignment -GroupId $GroupId
```

```Output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE M365 License Manager                Ask HR
```

This example retrieves the application role assignments of a group.

- `-GroupId` parameter specifies the ID of a group in Microsoft Entra ID.

### Example 2: Retrieve all application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraGroupAppRoleAssignment -GroupId 'ffffffffff-7777-9999-7777-vvvvvvvvvvv' -All
```

```Output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE M365 License Manager                Ask HR
```

This example retrieves all application role assignments of the specified group.

- `-GroupId` parameter specifies the ID of a group in Microsoft Entra ID.

### Example 3: Retrieve top two application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraGroupAppRoleAssignment -GroupId 'ffffffffff-7777-9999-7777-vvvvvvvvvvv' -Top 2
```

```Output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
MSVrBV4APk--eAGnHqMKBLflsQG3rU1EmDFKvgra41I Microsoft Device Management Checkin Ask HR
MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I ProvisioningPowerBi                 Ask HR
```

This example retrieves top two application role assignments of the specified group.

- `-GroupId` parameter specifies the ID of a group in Microsoft Entra ID.

## Parameters

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

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId
 
Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraGroup](Get-EntraGroup.md)

[New-EntraGroupAppRoleAssignment](New-EntraGroupAppRoleAssignment.md)

[Remove-EntraGroupAppRoleAssignment](Remove-EntraGroupAppRoleAssignment.md)
