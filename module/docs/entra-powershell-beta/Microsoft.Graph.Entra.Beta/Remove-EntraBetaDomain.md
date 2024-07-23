---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDomain

schema: 2.0.0
---

# Remove-EntraBetaDomain

## Synopsis
Removes a domain.

## Syntax

```
Remove-EntraBetaDomain -Name <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaDomain cmdlet removes a domain from Azure Active Directory (AD).

## Examples

### Example 1: Remove a domain
```
PS C:\>Remove-EntraBetaDomain -Name Contoso.com
```

This command removes a domain.

## Parameters

### -Name
Specifies the name of the domain to remove.

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

[Confirm-EntraBetaDomain]()

[Get-EntraBetaDomain]()

[New-EntraBetaDomain]()

[Set-EntraBetaDomain]()

