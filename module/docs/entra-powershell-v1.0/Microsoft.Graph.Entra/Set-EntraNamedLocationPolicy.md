---
title: Set-EntraNamedLocationPolicy
description: This article provides details on the Set-EntraNamedLocationPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
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

## EXAMPLES

### Example 1: Update an ip named location policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> Set-EntraNamedLocationPolicy -PolicyId 07a1f48d-0cbb-4c2c-8ea2-1ea00e3eb3b6 -OdataType "#microsoft.graph.ipNamedLocation" -IsTrusted $false
```

This command updates an ip named location policy in Microsoft Entra ID by PolicyId.

### Example 2: Update a country named location policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> Set-EntraNamedLocationPolicy -PolicyId 76fdfd4d-bd80-4c1e-8fd4-6abf49d121fe -OdataType "#microsoft.graph.countryNamedLocation" -IncludeUnknownCountriesAndRegions $true
```

This command updates a country named location policy in Microsoft Entra ID by PolicyId.

### Example 3: Update display name of a named location policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> Set-EntraNamedLocationPolicy -PolicyId 07a1f48d-0cbb-4c2c-8ea2-1ea00e3eb3b6 -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName NewName
```

This command updates display name of named location policy in Microsoft Entra ID by PolicyId.

## PARAMETERS

### -PolicyId
Specifies the ID of a named location policy in Microsoft Entra ID.

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

### -OdataType
Specifies the odata type of a named location policy object in Microsoft Entra ID.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IpRanges
Specifies the ip ranges of the named location policy in Microsoft Entra ID.

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
Specifies the isTrusted value for the named location policy in Microsoft Entra ID.

```yaml
Type: Boolean
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
Type: Boolean
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraNamedLocationPolicy](Get-EntraNamedLocationPolicy.md)

[New-EntraNamedLocationPolicy](New-EntraNamedLocationPolicy.md)

[Remove-EntraNamedLocationPolicy](Remove-EntraNamedLocationPolicy.md)

