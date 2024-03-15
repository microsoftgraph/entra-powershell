---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSPermissionGrantPolicy

## SYNOPSIS
Gets a permission grant policy.

## SYNTAX

### GetQuery (Default)
```
Get-EntraMSPermissionGrantPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraMSPermissionGrantPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSPermissionGrantPolicy cmdlet gets a Microsoft Entra ID permission grant policy.

## EXAMPLES

### Example 1: Get a permission grant policy by ID
```
PS C:\> Get-EntraMSPermissionGrantPolicy -Id "my_permission_grant_policy_id"
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraMSPermissionGrantPolicy]()

[Set-EntraMSPermissionGrantPolicy]()

[Remove-EntraMSPermissionGrantPolicy]()

