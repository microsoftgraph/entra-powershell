---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaContact

## Synopsis
gets a contact from Azure Active Directory.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaContact [-Filter <String>] [-All] [-Top <Int32>] [<CommonParameters>]
```

### GetById
```
Get-EntraBetaContact -ObjectId <String> [-All] [<CommonParameters>]
```

## Description
the Get-EntraBetaContact cmdlet gets a contact from Azure Active Directory.

## Examples

### Example 1 Retrieve all contact objects in the directory
```
PS C:\> Get-EntraBetaContact

ObjectId                             Mail                DisplayName
--------                             ----                -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com Contoso Contact
```

This command retrieves all contact objects in the directory.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a contact in Azure Active Directory.

```yaml
Type: String
Parameter Sets: GetById
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
Parameter Sets: GetQuery
Aliases:

Required: False
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

[Remove-EntraBetaContact]()

[Set-EntraBetaContact]()

