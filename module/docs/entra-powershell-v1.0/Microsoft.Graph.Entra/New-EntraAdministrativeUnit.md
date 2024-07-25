---
<<<<<<< HEAD
title: New-EntraAdministrativeUnit.
description: This article provides details on the New-EntraAdministrativeUnit command.
ms.service: entra
ms.topic: reference
ms.date: 06/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
=======
title: New-EntraAdministrativeUnit
description: This article provides details on the New-EntraAdministrativeUnit command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

>>>>>>> 6cd6824f9e532c51e54c1c0bde3f7f4323930e96
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraAdministrativeUnit

schema: 2.0.0
---

# New-EntraAdministrativeUnit

<<<<<<< HEAD
## SYNOPSIS

Creates an administrative unit.

## SYNTAX

```powershell
New-EntraAdministrativeUnit
 [-Description <String>] 
 -DisplayName <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The New-EntraAdministrativeUnit cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter for create an administrative unit

## EXAMPLES
=======
## Synopsis

Creates an administrative unit.

## Syntax

```powershell
New-EntraAdministrativeUnit 
 -DisplayName <String> 
 [-Description <String>]
 [<CommonParameters>]
```

## Description
The New-EntraAdministrativeUnit cmdlet creates an administrative unit in Microsoft Entra ID.

## Examples
>>>>>>> 6cd6824f9e532c51e54c1c0bde3f7f4323930e96

### Example 1: Create an administrative unit

```powershell
<<<<<<< HEAD
 New-EntraAdministrativeUnit -DisplayName 'test_130624_09' -Description 'test'
```

```output
deletedDateTime               :
visibility                    :
displayName                   : test_130624_09
membershipRule                :
@odata.context                : https://graph.microsoft.com/v1.0/$metadata#directory/administrativeUnits/$entity
membershipType                :
id                            :aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
description                   : test
membershipRuleProcessingState :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to create an administrative unit

## PARAMETERS
=======
 Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
 New-EntraAdministrativeUnit -DisplayName 'TestAU'
```

```Output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc             TestAU
```

This command creates an administrative unit.

### Example 2: Create an administrative unit using '-Description' parameter

```powershell
 Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
 New-EntraAdministrativeUnit -DisplayName 'Pacific Administrative Unit' -Description 'Administrative Unit for Pacific region'
```

```Output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee Administrative Unit for Pacific region     Pacific Administrative Unit
```

This command creates an administrative unit.

## Parameters
>>>>>>> 6cd6824f9e532c51e54c1c0bde3f7f4323930e96

### -Description

Specifies a description for the new administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name of the new administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

<<<<<<< HEAD
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
=======
## Inputs

## Outputs

## Notes

## Related Links
>>>>>>> 6cd6824f9e532c51e54c1c0bde3f7f4323930e96

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
<<<<<<< HEAD
=======

>>>>>>> 6cd6824f9e532c51e54c1c0bde3f7f4323930e96
