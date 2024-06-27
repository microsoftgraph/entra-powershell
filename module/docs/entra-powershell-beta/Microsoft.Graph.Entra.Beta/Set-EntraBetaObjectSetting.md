---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaObjectSetting

## Synopsis
Updates object settings.

## Syntax

```
Set-EntraBetaObjectSetting -Id <String> -DirectorySetting <DirectorySetting> -TargetType <String>
 -TargetObjectId <String> 
 [<CommonParameters>]
```

## Description
The Set-EntraBetaObjectSetting cmdlet updates the settings for an object in Azure Active Directory (AD).

## Examples

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -DirectorySetting
Specifies a DirectorySetting object.

```yaml
Type: DirectorySetting
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```



### -Id
Specifies the ID of a settings object.

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

### -TargetObjectId
Specifies the object ID of directory object.

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
Specifies the target type of a directory object.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaObjectSetting]()

[New-EntraBetaObjectSetting]()

[Remove-EntraBetaObjectSetting]()

