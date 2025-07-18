---
description: This article provides details on the Set-EntraBetaAdministrativeUnit command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/03/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaAdministrativeUnit
schema: 2.0.0
title: Set-EntraBetaAdministrativeUnit
---

# Set-EntraBetaAdministrativeUnit

## SYNOPSIS

Updates the properties of an administrative unit.

## SYNTAX

```powershell
Set-EntraBetaAdministrativeUnit
 -AdministrativeUnitId <String>
 [-Description <String>]
 [-DisplayName <String>]
 [-MembershipType <String>]
 [-MembershipRule <String>]
 [-MembershipRuleProcessingState <String>]
 [-Visibility <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaAdministrativeUnit` cmdlet updates the properties of an administrative unit in Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to update a specific administrative unit.

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission.

The following least-privileged roles are supported for this operation:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Update DisplayName and description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
Set-EntraBetaAdministrativeUnit -AdministrativeUnitId $administrativeUnit.Id -DisplayName 'Pacific Admin Unit' -Description 'Pacific Admin Unit Description' -MembershipType 'Assigned'
```

This Command update DisplayName of specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-DisplayName` parameter specifies the display name for the administrative unit.
- `-Description` parameter specifies the description for the administrative unit.

## PARAMETERS

### -Description

Specifies a description for the administrative unit.

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

Specifies a display name for the administrative unit.

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

### -AdministrativeUnitId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

Specifies the dynamic membership rule applied to the administrative unit. The possible values are: `dynamic`, `assigned`. If not set, the default value is `null` and the default behavior is `assigned`. This parameter is optional.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)

[Remove-EntraBetaAdministrativeUnit](Remove-EntraBetaAdministrativeUnit.md)
