---
author: msewaweru
description: This article provides details on the Set-EntraNamedLocationPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.SignIns
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.SignIns/Set-EntraNamedLocationPolicy
schema: 2.0.0
title: Set-EntraNamedLocationPolicy
---

# Set-EntraNamedLocationPolicy

## SYNOPSIS

Updates a named location policy in Microsoft Entra ID by PolicyId.

## SYNTAX

```powershell
Set-EntraNamedLocationPolicy
 -PolicyId <String>
 [-OdataType <String>]
 [-IpRanges <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]>]
 [-IncludeUnknownCountriesAndRegions <Boolean>]
 [-IsTrusted <Boolean>]
 [-DisplayName <String>]
 [-Id <String>]
 [-CountriesAndRegions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet allows an admin to update a named location policy in Microsoft Entra ID by PolicyId.

Conditional access policies are custom rules that define an access scenario.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the required permissions. Supported roles include:

- Security Administrator  
- Conditional Access Administrator

## EXAMPLES

### Example 1: Update an IP named location policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$policy = Get-EntraNamedLocationPolicy | Where-Object { "$_.DisplayName -eq 'IP named location policy'" }
$ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
$ipRanges.cidrAddress = '6.5.4.3/32'
$type = '#microsoft.graph.ipNamedLocation'
Set-EntraNamedLocationPolicy -PolicyId $policy.Id -OdataType $type -IsTrusted $false -IncludeUnknownCountriesAndRegions $false -IpRanges $ipRanges
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
$policy = Get-EntraNamedLocationPolicy | Where-Object { "$_.DisplayName -eq 'IP named location policy'" }
$type = '#microsoft.graph.countryNamedLocation'
Set-EntraNamedLocationPolicy -PolicyId $policy.Id -OdataType $type -IncludeUnknownCountriesAndRegions $true
```

This command updates a country named location policy in Microsoft Entra ID by PolicyId.

- `-PolicyId` parameter specifies the Id of a named location policy.
- `-OdataType` parameter specifies the odata type of a named location policy.
- `-IncludeUnknownCountriesAndRegions` parameter specifies the includeUnknownCountriesAndRegions value for the named location policy.

### Example 3: Update display name of a named location policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$policy = Get-EntraNamedLocationPolicy | Where-Object { "$_.DisplayName -eq 'IP named location policy'" }
$type = '#microsoft.graph.ipNamedLocation'
Set-EntraNamedLocationPolicy -PolicyId $policy.Id -OdataType $type -DisplayName 'NewName'
```

This command updates display name of named location policy in Microsoft Entra ID by PolicyId.

- `-PolicyId` parameter specifies the Id of a named location policy.
- `-OdataType` parameter specifies the odata type of a named location policy.
- `-DisplayName` parameter specifies the display name of a named location policy.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraNamedLocationPolicy](Get-EntraNamedLocationPolicy.md)

[New-EntraNamedLocationPolicy](New-EntraNamedLocationPolicy.md)

[Remove-EntraNamedLocationPolicy](Remove-EntraNamedLocationPolicy.md)
