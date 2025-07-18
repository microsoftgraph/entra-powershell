---
title: Set-EntraBetaNamedLocationPolicy
description: This article provides details on the Set-EntraBetaNamedLocationPolicy command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaNamedLocationPolicy

schema: 2.0.0
---

# Set-EntraBetaNamedLocationPolicy

## Synopsis

Updates a named location policy in Microsoft Entra ID by PolicyId.

## Syntax

```powershell
Set-EntraBetaNamedLocationPolicy
 -PolicyId <String>
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

This cmdlet allows an admin to update a named location policy in Microsoft Entra ID by PolicyId.

Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Update an IP named location policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$policy = Get-EntraBetaNamedLocationPolicy | Where-Object {"$_.DisplayName -eq 'IP named location policy'"}
$ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
$ipRanges.cidrAddress = '6.5.4.3/32'
$params = @{
    PolicyId = $policy.Id
    OdataType = '#microsoft.graph.ipNamedLocation'
    IsTrusted = $false
    IncludeUnknownCountriesAndRegions = $false
    IpRanges = $ipRanges
}
Set-EntraBetaNamedLocationPolicy @params
```

This example shows how to update an IP named location policy in Microsoft Entra ID by PolicyId.

- `-PolicyId` parameter specifies the Id of a named location policy.
- `-OdataType` parameter specifies the odata type of a named location policy.
- `-DisplayName` parameter specifies the display name of a named location policy.
- `-IsTrusted` parameter specifies the IsTrusted value for the named location policy.
- `-IpRanges` parameter specifies List of IP address ranges in IPv4 CIDR format (e.g., 1.2.3.4/32) or any valid IPv6 format as specified in IETF RFC596.

### Example 2: Update a country named location policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$policy = Get-EntraBetaNamedLocationPolicy | Where-Object {"$_.DisplayName -eq 'IP named location policy'"}
$params = @{
    PolicyId = $policy.Id
    OdataType = '#microsoft.graph.countryNamedLocation'
    IncludeUnknownCountriesAndRegions = $true
}
Set-EntraBetaNamedLocationPolicy @params
```

This command updates a country named location policy in Microsoft Entra ID by PolicyId.

- `-PolicyId` parameter specifies the Id of a named location policy.
- `-OdataType` parameter specifies the odata type of a named location policy.
- `-IncludeUnknownCountriesAndRegions` parameter specifies the includeUnknownCountriesAndRegions value for the named location policy.

### Example 3: Update display name of a named location policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$policy = Get-EntraBetaNamedLocationPolicy | Where-Object {"$_.DisplayName -eq 'IP named location policy'"}
$params = @{
    PolicyId = $policy.Id
    OdataType = '#microsoft.graph.ipNamedLocation'
    DisplayName = 'NewName'
}
Set-EntraBetaNamedLocationPolicy @params
```

This command updates display name of named location policy in Microsoft Entra ID by PolicyId.

- `-PolicyId` parameter specifies the Id of a named location policy.
- `-OdataType` parameter specifies the odata type of a named location policy.
- `-DisplayName` parameter specifies the display name of a named location policy.

## Parameters

### -PolicyId

Specifies the ID of a named location policy in Microsoft Entra ID.

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

Specifies the countries and regions for the named location policy in Microsoft Entra ID.

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

Specifies the Id of a named location policy in Microsoft Entra ID.

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

## Related Links

[New-EntraBetaNamedLocationPolicy](New-EntraBetaNamedLocationPolicy.md)

[Get-EntraBetaNamedLocationPolicy](Get-EntraBetaNamedLocationPolicy.md)

[Remove-EntraBetaNamedLocationPolicy](Remove-EntraBetaNamedLocationPolicy.md)
