---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaTrustFrameworkPolicy

## SYNOPSIS
This cmdlet is used to delete a trust framework policy (custom policy) in the directory.

## SYNTAX

```
Remove-EntraBetaTrustFrameworkPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to delete a trust framework policy in the directory.
The trust framework policy will be permanently deleted.

## EXAMPLES

### Example 1
```
PS C:\> Remove-EntraBetaTrustFrameworkPolicy -Id B2C_1A_signup_signin
```

This example removes the specified trust framework policy.

## PARAMETERS

### -Id
The unique identifier for a trust framework policy.

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

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
