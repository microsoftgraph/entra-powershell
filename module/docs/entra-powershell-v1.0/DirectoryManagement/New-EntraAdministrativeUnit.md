---
title: New-EntraAdministrativeUnit
description: This article provides details on the New-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 02/12/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraAdministrativeUnit

schema: 2.0.0
---

# New-EntraAdministrativeUnit

## Synopsis

Creates an administrative unit.

## Syntax

```powershell
New-EntraAdministrativeUnit
 -DisplayName <String>
 [-Description <String>]
 [-MembershipType <String>]
 [-MembershipRule <String>]
 [-MembershipRuleProcessingState <String>]
 [-Visibility <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraAdministrativeUnit` cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter to create an administrative unit.

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role that includes the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission. The following least-privileged roles are supported for this operation:

- Privileged Role Administrator

## Examples

### Example 1: Create an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
New-EntraAdministrativeUnit -DisplayName 'TestAU'
```

```Output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc             TestAU
```

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.

### Example 2: Create an administrative unit using '-Description' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
New-EntraAdministrativeUnit -DisplayName 'Pacific Administrative Unit' -Description 'Administrative Unit for Pacific region'
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc Pacific Administrative Unit     test111     False
```

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.
- `-Description` parameter specifies a description for the Administrative unit object.

### Example 3: Create an administrative unit with detailed configuration

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$displayName = 'Seattle District Technical Schools'
$description = 'Seattle district technical schools administration'
$membershipRule = '(user.country -eq "United States")'

New-EntraAdministrativeUnit `
    -DisplayName $displayName `
    -Description $description `
    -MembershipType 'Dynamic' `
    -MembershipRule $membershipRule `
    -MembershipRuleProcessingState 'On' `
    -Visibility 'HiddenMembership'
```

```Output
DeletedDateTime Id                                   Description                                       DisplayName                        Visibility
--------------- --                                   -----------                                       -----------                        ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc Seattle district technical schools administration Seattle District Technical Schools HiddenMembership
```

This example demonstrates how to create an administrative unit with detailed configuration information.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.
- `-Description` parameter specifies a description for the Administrative unit object.
- `-MembershipRule` parameter specifies the dynamic membership rule applied to the administrative unit.
- `-MembershipType` parameter specifies the membership type of the administrative unit. Possible values are: dynamic and assigned. If not set, the default value is null, and the membership type defaults to assigned.
- `-MembershipRuleProcessingState` parameter controls if the dynamic membership rule is active. Set to `On` to enable it or `Paused` to stop updates.
- `-Visibility` parameter specifies the visibility of the administrative unit. Defaults to `public` if not set. Set to `HiddenMembership` to hide membership from nonmembers.

## Parameters

### -Description

Specifies a description for the new administrative unit. This parameter is optional.

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

### -MembershipType

Specifies the membership type of the administrative unit. Possible values are: `dynamic` and `assigned`. If not set, the default value is `null`, and the membership type defaults to `assigned`. This parameter is optional.

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

### -MembershipRule

Specifies the dynamic membership rule applied to the administrative unit. This parameter is optional.

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

### -MembershipRuleProcessingState

Controls if the dynamic membership rule is active. Set to `On` to enable it or `Paused` to stop updates. This parameter is optional.

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

### -Visibility

Specifies the visibility of the administrative unit. Defaults to `public` if not set. Set to `HiddenMembership` to hide membership from nonmembers. This parameter is optional.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
