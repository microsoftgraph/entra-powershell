---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaObjectSetting

## Synopsis
deletes settings in Azure Active Directory.

## Syntax

```
Remove-EntraBetaObjectSetting -Id <String> -TargetType <String> -TargetObjectId <String>
 [<CommonParameters>]
```

## Description
the Remove-EntraBetaObjectSetting cmdlet removes object settings in Azure Active Directory (AD).

## Examples

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters



### -Id
Specfies the ID of a settings object in Azure AD.

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
Specifies the object ID of the target.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaObjectSetting]()

[New-EntraBetaObjectSetting]()

[Set-EntraBetaObjectSetting]()

