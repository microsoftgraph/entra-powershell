---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaConditionalAccessPolicy

## Synopsis
Deletes a conditional access policy in Azure Active Directory by Id.

## Syntax

```
Remove-EntraBetaConditionalAccessPolicy -PolicyId <String> [<CommonParameters>]
```

## Description
This cmdlet allows an admin to delete a conditional access policy in Azure Active Directory by Id.
Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Deletes a conditional access policy in Azure AD by PolicyId.
```
PS C:\> Remove-EntraBetaConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358
```

This command deletes a conditional access policy in Azure AD.

## Parameters

### -PolicyId
Specifies the policy id of a conditional access policy in Azure Active Directory.

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

[Get-EntraBetaConditionalAccessPolicy]()

[New-EntraBetaConditionalAccessPolicy]()

[Set-EntraBetaConditionalAccessPolicy]()

