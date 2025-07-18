---
title: New-EntraNamedLocationPolicy
description: This article provides details on the New-EntraNamedLocationPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraNamedLocationPolicy

schema: 2.0.0
---

# New-EntraNamedLocationPolicy

## Synopsis

Creates a new named location policy in Microsoft Entra ID.

## Syntax

```powershell
New-EntraNamedLocationPolicy
 [-OdataType <String>]
 [-Id <String>]
 [-DisplayName <String>]
 [-IpRanges <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]>]
 [-IsTrusted <Boolean>]
 [-CountriesAndRegions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]>]
 [-IncludeUnknownCountriesAndRegions <Boolean>]
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to create new named location policy in Microsoft Entra ID.

Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Creates a new Ip named location policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
$ipRanges.cidrAddress = '6.5.4.3/32'
$params = @{
    OdataType = '#microsoft.graph.ipNamedLocation'
    DisplayName = 'IP named location policy'
    IsTrusted = $false
    IpRanges = $ipRanges
}

New-EntraNamedLocationPolicy @params
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
$params = @{
    OdataType = '#microsoft.graph.countryNamedLocation'
    DisplayName = 'Country named location policy'
    CountriesAndRegions = 'IN'
    IncludeUnknownCountriesAndRegions = $false
}

New-EntraNamedLocationPolicy @params
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

## Related Links

[Get-EntraNamedLocationPolicy](Get-EntraNamedLocationPolicy.md)

[Set-EntraNamedLocationPolicy](Set-EntraNamedLocationPolicy.md)

[Remove-EntraNamedLocationPolicy](Remove-EntraNamedLocationPolicy.md)
