---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaObjectSetting

## Synopsis
gets an object setting.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaObjectSetting [-Top <Int32>] [-All] -TargetType <String> -TargetObjectId <String>
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaObjectSetting -Id <String> [-All] -TargetType <String> -TargetObjectId <String>
 [<CommonParameters>]
```

## Description
the Get-EntraBetaObjectSetting cmdlet gets an object setting from Azure Active Directory (AD).

## Examples

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the ID of a settings object.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetObjectId
Specifies the ID of the target object.

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

### -TargetType
Specifies the target type.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaObjectSetting]()

[Remove-EntraBetaObjectSetting]()

[Set-EntraBetaObjectSetting]()

