---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaNamedLocationPolicy

## Synopsis
Deletes an Azure Active Directory named location policy by PolicyId.

## Syntax

```
Remove-EntraBetaNamedLocationPolicy -PolicyId <String> [<CommonParameters>]
```

## Description
This cmdlet allows an admin to delete the Azure Active Directory named location policy.
Named locations are custom rules that define network locations which can then be used in a Conditional Access policy.

## Examples

### Example 1: Deletes a named location policy in Azure AD with given PolicyId.
```
PS C:\> Remove-EntraBetaNamedLocationPolicy -PolicyId 76fdfd4d-bd80-4c1e-8fd4-6abf49d121fe
```

This command deletes a named location policy in Azure AD.

## Parameters

### -PolicyId
Specifies the ID of a named location policy in Azure Active Directory.

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

[New-EntraBetaNamedLocationPolicy]()

[Set-EntraBetaNamedLocationPolicy]()

[Get-EntraBetaNamedLocationPolicy]()

