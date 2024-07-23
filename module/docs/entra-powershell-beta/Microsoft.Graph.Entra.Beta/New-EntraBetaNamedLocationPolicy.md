---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaNamedLocationPolicy

schema: 2.0.0
---

# New-EntraBetaNamedLocationPolicy

## Synopsis
Creates a new named location policy in Azure Active Directory.

## Syntax

```
New-EntraBetaNamedLocationPolicy [-IncludeUnknownCountriesAndRegions <Boolean>] [-Id <String>]
 [-IsTrusted <Boolean>] [-OdataType <String>]
 [-CountriesAndRegions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]>]
 [-IpRanges <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]>] [-DisplayName <String>]
 [<CommonParameters>]
```

## Description
This cmdlet allows an admin to create new named location policy in Azure Active Directory.
Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Creates a new Ip named location policy in Azure AD.
```
PS C:\> $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
          PS C:\> $ipRanges.cidrAddress = "6.5.4.3/32"
          PS C:\> New-EntraBetaNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "IP named location policy" -IsTrusted $false -IpRanges $ipRanges

          OdataType               : #microsoft.graph.ipNamedLocation
          Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
          DisplayName             : IP named location policy
          CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
          IsTrusted               : false
          IpRanges                : {
                                      class IpRange {
                                        CidrAddress: 6.5.4.3/32
                                      }
                                    }
```

This command creates a new country named location policy in Azure AD.

### Example 2: Creates a new country named location policy in Azure AD.
```
PS C:\> New-EntraBetaNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "Country named location policy" -CountriesAndRegions "IN" -IncludeUnknownCountriesAndRegions $false

          OdataType                         : #microsoft.graph.countryNamedLocation
          Id                                : 13975bae-089f-4358-8da3-cc262f29276b
          DisplayName                       : Country named location policy
          CreatedDateTime                   : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime                  : 2019-09-27T00:12:12.5986473Z
          CountriesAndRegions               : {IN}
          IncludeUnknownCountriesAndRegions : False
```

This command creates a new country named location policy in Azure AD.

## Parameters

### -OdataType
Specifies the odata type of a named location policy object in Azure Active Directory.

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
Specifies the display name of a named location policy in Azure Active Directory.

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
Specifies the ip ranges of the named location policy in Azure Active Directory.

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
Specifies the isTrusted value for the named location policy in Azure Active Directory.

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
Specifies the countries and regions for the named location policy in Azure Active Directory.

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
Specifies the includeUnknownCountriesAndRegions value for the named location policy in Azure Active Directory.

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
{{ Fill Id Description }}

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

## Inputs

## Outputs

## Notes
## Related Links

[Get-EntraBetaNamedLocationPolicy]()

[Set-EntraBetaNamedLocationPolicy]()

[Remove-EntraBetaNamedLocationPolicy]()

