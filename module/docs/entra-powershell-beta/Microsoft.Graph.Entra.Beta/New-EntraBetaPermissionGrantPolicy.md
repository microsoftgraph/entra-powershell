---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaPermissionGrantPolicy

schema: 2.0.0
---

# New-EntraBetaPermissionGrantPolicy

## Synopsis
Creates a permission grant policy.

## Syntax

```
New-EntraBetaPermissionGrantPolicy [-Description <String>] [-DisplayName <String>] [-Id <String>]
 [<CommonParameters>]
```

## Description
The New-EntraBetaPermissionGrantPolicy cmdlet creates an Azure Active Directory permission grant policy.

## Examples

### Example 1: Create a permission grant policy
```
PS C:\> New-EntraBetaPermissionGrantPolicy -Id "my_new_permission_grant_policy_id"  -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy"
```

## Parameters

### -Description
Specifies the description for the permission grant policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name for the permission grant policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the unique identifier of the permission grant policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaPermissionGrantPolicy]()

[Set-EntraBetaPermissionGrantPolicy]()

[Remove-EntraBetaPermissionGrantPolicy]()

