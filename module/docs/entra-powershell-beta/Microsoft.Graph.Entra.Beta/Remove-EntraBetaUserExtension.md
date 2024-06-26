---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaUserExtension

## Synopsis
Removes a user extension.

## Syntax

### SetMultiple
```
Remove-EntraBetaUserExtension -ObjectId <String>
 -ExtensionNames <System.Collections.Generic.List`1[System.String]> [<CommonParameters>]
```

### SetSingle
```
Remove-EntraBetaUserExtension -ObjectId <String> -ExtensionName <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaUserExtension cmdlet removes a user extension from Azure Active Directory (AD).

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -ExtensionName
Specifies the name of an extension.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNames
Specifies an array of extension names.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies an object ID.

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

[Get-EntraBetaUserExtension]()

[Set-EntraBetaUserExtension]()

