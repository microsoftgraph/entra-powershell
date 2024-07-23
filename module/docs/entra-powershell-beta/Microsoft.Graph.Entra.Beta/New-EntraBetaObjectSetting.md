---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaObjectSetting

schema: 2.0.0
---

# New-EntraBetaObjectSetting

## Synopsis
Creates a settings object.

## Syntax

```
New-EntraBetaObjectSetting -DirectorySetting <DirectorySetting> -TargetType <String> -TargetObjectId <String>
 [<CommonParameters>]
```

## Description
The New-EntraBetaObjectSetting cmdlet creates a settings object in Azure Active Directory (AD).

## Examples

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -DirectorySetting
Specifies the new settings.

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


### -TargetObjectId
Specifies the ID of directory object to which to assign settings.

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
Specifies the type of the directory object to which to assign settings.

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

[Remove-EntraBetaObjectSetting]()

[Set-EntraBetaObjectSetting]()

