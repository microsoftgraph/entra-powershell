---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalPolicy

## Synopsis

## Syntax

```
Remove-EntraBetaServicePrincipalPolicy -Id <String> -PolicyId <String> [<CommonParameters>]
```

## Description

## Examples

### Example 1: Remove a service principal policy
```
PS C:\>Remove-EntraBetaApplicationPolicy -ObjectId <object id of application> -PolicyId <object id of policy>
```

This command removes a service principal policy.

## Parameters



### -PolicyId
Specifies the object ID of a policy.

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

### -Id
{{Fill Id Description}}

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

[Add-EntraBetaServicePrincipalPolicy]()

[Get-EntraBetaServicePrincipalPolicy]()

