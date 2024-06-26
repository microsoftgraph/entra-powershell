---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaMSDeletedDirectoryObject

## Synopsis
This cmdlet is used to permanently delete a previously deleted directory object

## Syntax

```
Remove-EntraBetaMSDeletedDirectoryObject -Id <String> [<CommonParameters>]
```

## Description
This cmdlet is used to permanently delete a previously deleted directory object.
When a directory object is permanently deleted it can no longer be restored.

## Examples

### Example 1
```
Remove-EntraBetaMSDeletedDirectoryObject -Id aa644285-eb75-4389-885e-7233f096984c
```

This example shows how to permanently delete a previously deleted directory object with Id = aa644285-eb75-4389-885e-7233f096984c

## Parameters

### -Id
The Id of the directory object that is permanently deleted

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

## Related LINKS
