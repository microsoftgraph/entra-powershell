---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSPermissionGrantPolicy

## SYNOPSIS
Gets a permission grant policy.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSPermissionGrantPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSPermissionGrantPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSPermissionGrantPolicy cmdlet gets an Azure Active Directory permission grant policy.

## EXAMPLES

### Example 1: Get a permission grant policy by ID
```
PS C:\> Get-EntraBetaMSPermissionGrantPolicy -Id "my_permission_grant_policy_id"
```

## PARAMETERS

### -Id
Specifies the unique identifier of the permission grant policy.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaMSPermissionGrantPolicy]()

[Set-EntraBetaMSPermissionGrantPolicy]()

[Remove-EntraBetaMSPermissionGrantPolicy]()

