---
title: Add-EntraAdministrativeUnitMember
description: This article provides details on the Add-EntraAdministrativeUnitMember command.

<<<<<<< HEAD
ms.service: active-directory
ms.topic: reference
ms.date: 05/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
=======

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraAdministrativeUnitMember

<<<<<<< HEAD
## SYNOPSIS

Adds an administrative unit member.

## SYNTAX
=======
## Synopsis

Adds an administrative unit member.

## Syntax
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

```powershell
Add-EntraAdministrativeUnitMember 
 -RefObjectId <String> 
<<<<<<< HEAD
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraAdministrativeUnitMember cmdlet adds a Microsoft Entra ID administrative unit member.

## EXAMPLES

### Example 1: Add an administrative unit member
```powershell
Add-EntraAdministrativeUnitMember -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ObjectId "dddddddd-2222-2222-3333-cccccccccccc"
```
This example demonstrated how to add administrative unit member.
## PARAMETERS

### -ObjectId
=======
 -Id <String> 
 [<CommonParameters>]
```

## Description
The **Add-EntraAdministrativeUnitMember** cmdlet adds a Microsoft Entra ID administrative unit member.

## Examples

### Example 1: Add user as an administrative unit member

```powershell
PS C:\>Add-EntraAdministrativeUnitMember -Id f306a126-cf2e-439d-b20f-95ce4bcb7ffa -RefObjectId d6873b36-81d6-4c5e-bec0-9e3ca2c86846
```

This command adds a user as an administrative unit member.

`-Id` - specifies the unique identifier (ID) of the administrative unit to which you want to add a member. In this example, `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` represents the ID of the administrative unit.

`-RefObjectId` - specifies the unique identifier (Object ID) of the user or group you want to add as a member of the administrative unit. In this example, `dddddddd-3333-4444-5555-eeeeeeeeeeee` is the Object ID of the user or group being added.

Administrative units can help manage permissions and access in a more granular way, especially in large organizations or in scenarios where administrative responsibilities are divided among different departments or regions.

## Parameters

### -Id

>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa
Specifies the ID of a Microsoft Entra ID administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RefObjectId
<<<<<<< HEAD
Specifies the unique ID of the specific Microsoft Entra ID object that assign as owner/manager/member.
=======

Specifies the unique ID of the specific Microsoft Entra ID object that are as owner/manager/member.
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
<<<<<<< HEAD
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
=======

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)

>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa
