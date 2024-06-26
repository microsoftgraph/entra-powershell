---
External help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaFederationProperty

## Synopsis
For the specified domain, displays the properties of the Active Directory Federation Services 2.0 server and Microsoft Online.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaFederationProperty [-SupportMultipleDomain] [<CommonParameters>]
```

### GetById
```
Get-EntraBetaFederationProperty -DomainName <String> [<CommonParameters>]
```

## Description
The Get-EntraBetaFederationProperty cmdlet gets key settings from both the Active Directory Federation Services 2.0 server and Microsoft Online.
You can use this
Information to troubleshoot authentication problems caused by mismatched settings between the Active Directory Federation Services 2.0 server and Microsoft Online.

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -DomainName
The domain name for which the properties from both the Active Directory Federation Services 2.0 server and Microsoft Online will be displayed.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SupportMultipleDomain
{{ Fill SupportMultipleDomain Description }}

```yaml
Type: SwitchParameter
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
