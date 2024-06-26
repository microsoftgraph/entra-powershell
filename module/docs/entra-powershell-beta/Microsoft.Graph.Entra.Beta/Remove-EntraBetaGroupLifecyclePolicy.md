---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaGroupLifecyclePolicy

## Synopsis
deletes a groupLifecyclePolicies object

## Syntax

```
Remove-EntraBetaGroupLifecyclePolicy -Id <String> [<CommonParameters>]
```

## Description
the Remove-EntraBetaGroupLifecyclePolicy command deletes a groupLifecyclePolicies object in Azure Active Directory.

## Examples

### Example 1
```
PS C:\> Remove-EntraBetaGroupLifecyclePolicy -Id "13bed58e-6144-41e5-abbd-47c95964e671"
```

This cmdlet deletes the groupLifecyclePolicies object that has the specified ID.

## Parameters

### -Id
Specifies the ID of the groupLifecyclePolicies object that this cmdlet removes.

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
