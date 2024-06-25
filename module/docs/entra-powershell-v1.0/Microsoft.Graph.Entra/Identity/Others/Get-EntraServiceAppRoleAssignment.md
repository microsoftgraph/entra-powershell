---
title: Get-EntraServiceAppRoleAssignment.
description: This article provides details on the Get-EntraServiceAppRoleAssignment command.

ms.service: entra
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServiceAppRoleAssignment

## Synopsis
Gets a service principal application role assignment.

## Syntax

```powershell
Get-EntraServiceAppRoleAssignment 
 -ObjectId <String>
 [-All]
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description
The Get-EntraServiceAppRoleAssignment cmdlet gets a role assignment for a service principal application in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the application role assignments for a service principal

```powershell
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServiceAppRoleAssignment -ObjectId $ServicePrincipalId
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- -------------------
                MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE 00000000-0000-0000-0000-000000000000 29-02-2024 05:53:00 Ask HR               056b2531-005e-4f3e-be78-01a71ea30a04 Group         M365 License Manager
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the application role assignments for the service principal in identified by $ServicePrincipalId.

### Example 2: Retrieve all application role assignments for a service principal
```powershell
PS C:\> Get-EntraServiceAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -All
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------     -------------------- -----------
                qjltmaz9l02qPcgftHNirITXiOnmHR5GmW_oEXl_ZL8 00000000-0000-0000-0000-000000000000 07/07/2023 17:03:59 MOD Administrator    996d39aa-fdac-4d97-aa3d-c81fb4...
                0ekrQWAUYUCO7cyiA_yyFYFF7ENp2l9Alu5oP9S5INQ 00000000-0000-0000-0000-000000000000 31/07/2023 04:29:57 Adele Vance          412be9d1-1460-4061-8eed-cca203...
                MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I 00000000-0000-0000-0000-000000000000 29/02/2024 05:53:51 Ask HR               056b2531-005e-4f3e-be78-01a71e...
```

This command gets all application role assignments for specified service principal.

### Example 3: Retrieve the top five application role assignments for a service principal
```powershell
PS C:\> Get-EntraServiceAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -Top 3
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------     -------------------- -----------
                qjltmaz9l02qPcgftHNirITXiOnmHR5GmW_oEXl_ZL8 00000000-0000-0000-0000-000000000000 07/07/2023 17:03:59 MOD Administrator    996d39aa-fdac-4d97-aa3d-c81fb4...
                0ekrQWAUYUCO7cyiA_yyFYFF7ENp2l9Alu5oP9S5INQ 00000000-0000-0000-0000-000000000000 31/07/2023 04:29:57 Adele Vance          412be9d1-1460-4061-8eed-cca203...
                MSVrBV4APk--eAGnHqMKBExhQK4StEFHidLvUymzo4I 00000000-0000-0000-0000-000000000000 29/02/2024 05:53:51 Ask HR               056b2531-005e-4f3e-be78-01a71e...

```
This command gets three application role assignments for specified service principal.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```
### -ObjectId
Specifies the ID of a service principal in Microsoft Entra ID.

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
The maximum number of records to return.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServiceAppRoleAssignment](New-EntraServiceAppRoleAssignment.md)

[Remove-EntraServiceAppRoleAssignment](Remove-EntraServiceAppRoleAssignment.md)