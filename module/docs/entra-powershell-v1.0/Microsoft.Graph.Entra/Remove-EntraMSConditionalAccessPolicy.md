---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSConditionalAccessPolicy

## SYNOPSIS
Deletes a conditional access policy in Microsoft Entra ID by Id.

## SYNTAX

```
Remove-EntraMSConditionalAccessPolicy -PolicyId <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to delete a conditional access policy in Microsoft Entra ID by Id.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Deletes a conditional access policy in Azure AD by PolicyId.
```
PS C:\> Remove-EntraMSConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358
```

This command deletes a conditional access policy in Azure AD.

## PARAMETERS

### -PolicyId
Specifies the policy id of a conditional access policy in Microsoft Entra ID.

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

[Get-EntraMSConditionalAccessPolicy]()

[New-EntraMSConditionalAccessPolicy]()

[Set-EntraMSConditionalAccessPolicy]()

