---
author: msewaweru
description: This article provides details on the Remove-EntraBetaAdministrativeUnitMember command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/04/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Remove-EntraBetaAdministrativeUnitMember
schema: 2.0.0
title: Remove-EntraBetaAdministrativeUnitMember
---

# Remove-EntraBetaAdministrativeUnitMember

## SYNOPSIS

Removes an administrative unit member.

## SYNTAX

```powershell
Remove-EntraBetaAdministrativeUnitMember
 -AdministrativeUnitId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify `AdministrativeUnitId` and `MemberId` to remove an administrative unit member.

To remove a member from an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## EXAMPLES

### Example 1: Remove an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$adminUnitMember = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id | Select-Object Id, DisplayName,'@odata.type' | Where-Object {$_.DisplayName -eq 'Saywer Miller'}
Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $adminUnitMember.Id
```

This command removes a specified member (user or group) from a specified administrative unit.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `-MemberId` parameter specifies the ID of the administrative unit member.

## PARAMETERS

### -MemberId

Specifies the ID of the administrative unit member.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaAdministrativeUnitMember](Add-EntraBetaAdministrativeUnitMember.md)

[Get-EntraBetaAdministrativeUnitMember](Get-EntraBetaAdministrativeUnitMember.md)

[New-EntraBetaAdministrativeUnitMember](New-EntraBetaAdministrativeUnitMember.md)
