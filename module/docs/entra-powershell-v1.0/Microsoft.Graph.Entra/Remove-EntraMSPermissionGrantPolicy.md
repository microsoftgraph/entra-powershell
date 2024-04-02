---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSPermissionGrantPolicy

## SYNOPSIS
Removes a permission grant policy.

## SYNTAX

```
Remove-EntraMSPermissionGrantPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraMSPermissionGrantPolicy cmdlet removes a Microsoft Entra ID permission grant policy.

## EXAMPLES

### Example 1: Remove a permission grant policy
```
PS C:\> Remove-EntraMSPermissionGrantPolicy -Id "my_permission_grant_policy_id"
```

## PARAMETERS

### -Id
The unique identifier of the permission grant policy.

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

[New-EntraMSPermissionGrantPolicy]()

[Get-EntraMSPermissionGrantPolicy]()

[Set-EntraMSPermissionGrantPolicy]()

