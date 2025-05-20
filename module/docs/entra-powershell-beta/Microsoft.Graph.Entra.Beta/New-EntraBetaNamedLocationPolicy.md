---
title: New-EntraBetaNamedLocationPolicy
description: This article provides details on the New-EntraBetaNamedLocationPolicy command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaNamedLocationPolicy

schema: 2.0.0
---

# New-EntraBetaNamedLocationPolicy

## Synopsis

Creates a new named location policy in Microsoft Entra ID.

## Syntax

```powershell
New-EntraBetaNamedLocationPolicy
 [-IncludeUnknownCountriesAndRegions <Boolean>]
 [-Id <String>]
 [-IsTrusted <Boolean>]
 [-OdataType <String>]
 [-CountriesAndRegions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]>]
 [-IpRanges <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to create new named location policy in Microsoft Entra ID.

Conditional access policies are custom rules that define an access scenario.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the required permissions. The least privileged roles for this operation are:

- Security Administrator  
- Conditional Access Administrator

## Examples

### Example 1: Creates a new Ip named location policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
$ipRanges.cidrAddress = '6.5.4.3/32'
$type = '#microsoft.graph.ipNamedLocation'
New-EntraBetaNamedLocationPolicy -OdataType $type -DisplayName 'IP named location policy' -IsTrusted $false -IpRanges $ipRanges
```

```Output
Id                                   CreatedDateTime     DisplayName              ModifiedDateTime
--                                   ---------------     -----------              ----------------
bbbbbbbb-1111-2222-3333-cccccccccccc 31-07-2024 10:45:27 IP named location policy 31-07-2024 10:45:27
```

This command creates a new country named location policy in Microsoft Entra ID.

- `-OdataType` parameter specifies the odata type of a named location policy.
- `-DisplayName` parameter specifies the display name of a named location policy.
- `-IsTrusted` parameter specifies the IsTrusted value for the named location policy.
- `-IpRanges` parameter specifies List of IP address ranges in IPv4 CIDR format (e.g., 1.2.3.4/32) or any valid IPv6 format as specified in IETF RFC596.

### Example 2: Creates a new country named location policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$type = '#microsoft.graph.countryNamedLocation'
New-EntraBetaNamedLocationPolicy -OdataType $type -DisplayName 'Country named location policy' -CountriesAndRegions 'IN' -IncludeUnknownCountriesAndRegions $false
```

```Output
Id                                   CreatedDateTime     DisplayName                   ModifiedDateTime
--                                   ---------------     -----------                   ----------------
cccccccc-2222-3333-4444-dddddddddddd 31-07-2024 10:46:16 Country named location policy 31-07-2024 10:46:16
```

This command creates a new country named location policy in Microsoft Entra ID.

- `-OdataType` parameter specifies the odata type of a named location policy.
- `-DisplayName` parameter specifies the display name of a named location policy.
- `-CountriesAndRegions` parameter specifies the countries and regions for the named location policy.
- `-IncludeUnknownCountriesAndRegions` parameter specifies the includeUnknownCountriesAndRegions value for the named location policy.

## Parameters

### -OdataType

Specifies the OData type of a named location policy object in Microsoft Entra ID.

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

Specifies the display name of a named location policy in Microsoft Entra ID.

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

### -IpRanges

List of IP address ranges in IPv4 CIDR format (e.g., 1.2.3.4/32) or any valid IPv6 format as specified in IETF RFC596. The @odata.type of the ipRange is also required.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsTrusted

Specifies the `IsTrusted` value for the named location policy in Microsoft Entra ID.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CountriesAndRegions

Specifies the countries and regions for the named location policy in Microsoft Entra ID. List of countries and/or regions in the two-letter format specified by ISO 3166-2.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeUnknownCountriesAndRegions

Specifies the includeUnknownCountriesAndRegions value for the named location policy in Microsoft Entra ID.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the ID of a named location policy in Microsoft Entra ID.

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

- For more information, see [Create namedLocation](/graph/api/conditionalaccessroot-post-namedlocations).

## Related links

[Get-EntraBetaNamedLocationPolicy](Get-EntraBetaNamedLocationPolicy.md)

[Set-EntraBetaNamedLocationPolicy](Set-EntraBetaNamedLocationPolicy.md)

[Remove-EntraBetaNamedLocationPolicy](Remove-EntraBetaNamedLocationPolicy.md)
