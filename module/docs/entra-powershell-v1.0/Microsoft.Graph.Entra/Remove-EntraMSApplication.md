---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSApplication

## SYNOPSIS
Deletes an application object.

## SYNTAX

```
Remove-EntraMSApplication -ObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
Deletes an application object identified by objectId.

## EXAMPLES

### Example 1: Remove an application
```
PS C:\>Remove-EntraMSApplication -ObjectId "acd10942-5747-4385-8824-4c5d5fa904f9"
```

This command removes the specified application.

## PARAMETERS

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSApplication]()

[New-EntraMSApplication]()

[Set-EntraMSApplication]()

