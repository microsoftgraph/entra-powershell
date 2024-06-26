---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaLifecyclePolicyGroup

## Synopsis
retrieves the lifecycle policy object to which a group belongs.

## Syntax

```
Get-EntraBetaLifecyclePolicyGroup -Id <String> [<CommonParameters>]
```

## Description
the Get-EntraBetaLifecyclePolicyGroup retrieves the lifecycle policy object to which a group belongs.

## Examples

### Example 1
```
PS C:\> Get-EntraBetaLifecyclePolicyGroup -Id cffd97bd-6b91-4c4e-b553-6918a320211c
```

This command retrieves the lifecycle policy object to which a group belongs.

## Parameters

### -Id
Specifies the ID of a group in Azure Active Directory

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
