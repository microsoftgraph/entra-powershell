---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraContactMembership

## SYNOPSIS
Get a contact membership.

## SYNTAX

```
Get-EntraContactMembership [-All <Boolean>] -ObjectId <String> [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraContactMembership cmdlet gets a contact membership in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the memberships of a contact
```
PS C:\> $Contact = Get-EntraContact -Top 1
PS C:\> Get-EntraContactMembership -ObjectId $Contact.ObjectId

ObjectId                             ObjectType
--------                             ----------
0015df25-808e-4715-9c24-a6929c25c201 Group
```

The first command gets a contact by using the Get-EntraContact (./Get-EntraContact.md)cmdlet, and then stores it in the $Contact variable.

The second command gets the memberships for $Contact.

## PARAMETERS

### -All
If true, return all memberships.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a contact in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-EntraContact]()

