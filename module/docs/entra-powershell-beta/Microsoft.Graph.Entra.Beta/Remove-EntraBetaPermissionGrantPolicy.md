---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaPermissionGrantPolicy

## Synopsis
Removes a permission grant policy.

## Syntax

```
Remove-EntraBetaPermissionGrantPolicy -Id <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaPermissionGrantPolicy cmdlet removes an Azure Active Directory permission grant policy.

## Examples

### Example 1: Remove a permission grant policy
```
PS C:\> Remove-EntraBetaPermissionGrantPolicy -Id "my_permission_grant_policy_id"
```

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaPermissionGrantPolicy]()

[Get-EntraBetaPermissionGrantPolicy]()

[Set-EntraBetaPermissionGrantPolicy]()

