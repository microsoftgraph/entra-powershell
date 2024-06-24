---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationVerifiedPublisher

## SYNOPSIS
Removes the verified publisher from an application.

## SYNTAX

```
Remove-EntraBetaApplicationVerifiedPublisher -AppObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
Removes the verified publisher from an application.

## EXAMPLES

### Example 1: Remove the verified publisher from an application.
```
$appObjId = 'ad6c71a5-e48f-4320-bb59-92642a2d8d9f'
          Remove-EntraBetaApplicationVerifiedPublisher -AppObjectId $appObjId
```

## PARAMETERS

### -AppObjectId
The unique identifier of an Azure Active Directory Application object.

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

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraBetaApplicationVerifiedPublisher]()

