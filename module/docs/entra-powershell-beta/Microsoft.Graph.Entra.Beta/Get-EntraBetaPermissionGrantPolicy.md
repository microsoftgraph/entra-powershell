---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaPermissionGrantPolicy

## Synopsis
Gets a permission grant policy.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaPermissionGrantPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaPermissionGrantPolicy -Id <String> [<CommonParameters>]
```

## Description
The Get-EntraBetaPermissionGrantPolicy cmdlet gets an Azure Active Directory permission grant policy.

## Examples

### Example 1: Get a permission grant policy by ID
```
PS C:\> Get-EntraBetaPermissionGrantPolicy -Id "my_permission_grant_policy_id"
```

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaPermissionGrantPolicy]()

[Set-EntraBetaPermissionGrantPolicy]()

[Remove-EntraBetaPermissionGrantPolicy]()

