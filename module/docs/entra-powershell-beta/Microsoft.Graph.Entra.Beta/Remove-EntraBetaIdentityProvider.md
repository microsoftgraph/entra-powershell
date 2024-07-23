---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaIdentityProvider

schema: 2.0.0
---

# Remove-EntraBetaIdentityProvider

## Synopsis
This cmdlet is used to delete an identity provider in the directory.

## Syntax

```
Remove-EntraBetaIdentityProvider -Id <String> [<CommonParameters>]
```

## Description
This cmdlet is used to delete an identity provider that has been configured in the directory.
The identity provider will be permanently deleted.

## Examples

### Example 1
```
PS C:\> Remove-EntraBetaIdentityProvider -Id LinkedIn-OAUTH
```

This example removes the specified identity provider.

## Parameters

### -Id
The unique identifier for an identity provider.

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

### System.String
## Outputs

### System.Object
## Notes

## Related Links
