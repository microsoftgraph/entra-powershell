---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaDirectorySetting

schema: 2.0.0
---

# Set-EntraBetaDirectorySetting

## Synopsis
Updates a directory setting in Azure Active Directory.

## Syntax

```
Set-EntraBetaDirectorySetting -DirectorySetting <DirectorySetting> -Id <String>
 [<CommonParameters>]
```

## Description
The Set-EntraBetaDirectorySetting cmdlet updates a directory setting in Azure Active Directory (AD).

## Examples

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -DirectorySetting
Specifies the directory settings.

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
Specifies the ID of a settings object in Azure AD.

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

[Get-EntraBetaDirectorySetting]()

[New-EntraBetaDirectorySetting]()

[Remove-EntraBetaDirectorySetting]()

