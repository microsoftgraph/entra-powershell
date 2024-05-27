---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaAdministrativeUnitMember

## SYNOPSIS
Gets a member of an administrative unit.

## SYNTAX

```
Get-EntraBetaAdministrativeUnitMember -ObjectId <String> [-All] [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaAdministrativeUnitMember cmdlet gets a member of an Active Directory administrative unit.

## EXAMPLES

### Example 1 Get an administrative unit member by ID
```
PS C:\> Get-EntraBetaAdministrativeUnitMember -ObjectId "ef08b536-9d0a-4f8f-bda5-8b9cd01a9159"
```

## PARAMETERS


### -ObjectId
Specifies the ID of an administrative unit in Azure Active Directory.

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

[Add-EntraBetaAdministrativeUnitMember]()

[Remove-EntraBetaAdministrativeUnitMember]()