---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaPolicy

## Synopsis
Removes a policy.

## Syntax

```
Remove-EntraBetaPolicy -Id <String> 
 [<CommonParameters>]
```

## Description
The Remove-EntraBetaPolicy cmdlet removes a policy from Azure Active Directory (AD).

## Examples

### Example 1: Remove a policy
```
PS C:\>Remove-EntraBetaPolicy -Id *<ID>*.
```

This command removes the specified policy.

## Parameters



### -Id
The Id of the policy you want to remove

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

[Get-EntraBetaPolicy]()

[New-EntraBetaPolicy]()

[Set-EntraBetaPolicy]()

