---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaContactManager

## SYNOPSIS
Gets the manager of a contact.

## SYNTAX

```
Get-EntraBetaContactManager -ObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaContactManager cmdlet gets the manager of a contact in Azure Active Directory.

## EXAMPLES

### Example 1: Get the manager of a contact
```
PS C:\> $Contact = Get-EntraBetaContact -Top 1
PS C:\> Get-EntraBetaContactManager -ObjectId $Contact.ObjectId
```

The first command gets a contact by using the Get-EntraBetaContact (./Get-EntraBetaContact.md)cmdlet, and then stores it in the $Contact variable.

The second command gets the manager for $Contact.

## PARAMETERS


### -ObjectId
Specifies the ID of a contact in Azure Active Directory.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaContact]()

[Remove-EntraBetaContactManager]()

[Set-EntraBetaContactManager]()

