---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaContact

schema: 2.0.0
---

# Remove-EntraBetaContact

## Synopsis
Removes a contact.

## Syntax

```
Remove-EntraBetaContact -ObjectId <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaContact removes a contact from Azure Active Directory (AD).

## Examples

### Example 1: Remove a contact
```
PS C:\> $Contact = Get-EntraBetaContact -Top 1
PS C:\> Remove-EntraBetaContact -ObjectId $Contact.ObjectId
```

The first command gets a contact by using the Get-EntraBetaContact (./Get-EntraBetaContact.md)cmdlet, and then stores it in the $Contact variable.

The second command removes the contact in $Contact.

## Parameters



### -ObjectId
Specifies the object ID of a contact in Azure AD.

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

[Get-EntraBetaContact]()

