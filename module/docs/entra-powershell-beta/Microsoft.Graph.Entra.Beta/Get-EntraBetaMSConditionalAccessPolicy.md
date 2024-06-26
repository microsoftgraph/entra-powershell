---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSConditionalAccessPolicy

## Synopsis
Gets an Azure Active Directory conditional access policy.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaMSConditionalAccessPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSConditionalAccessPolicy -PolicyId <String> [<CommonParameters>]
```

## Description
This cmdlet allows an admin to get the Azure Active Directory conditional access policy.
Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Retrieves a list of all conditional access policies in Azure AD.
```
PS C:\> Get-EntraBetaMSConditionalAccessPolicy

          Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
          DisplayName             : Demo app for documentation
          CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
          State                   : Disabled
```

This command retrieves a list of all conditional access policies in Azure AD.

### Example 2: Retrieves a conditional access policy in Azure AD with given Id.
```
PS C:\> Get-EntraBetaMSConditionalAccessPolicy -PolicyId "6b5e999b-0ba8-4186-a106-e0296c1c4358"

          Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
          DisplayName             : Demo app for documentation
          CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
          State                   : Disabled
```

This command retrieves a conditional access policy in Azure AD.

## Parameters

### -PolicyId
Specifies the ID of a conditional access policy in Azure Active Directory.

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
## Related LINKS

[New-EntraBetaMSConditionalAccessPolicy]()

[Set-EntraBetaMSConditionalAccessPolicy]()

[Remove-EntraBetaMSConditionalAccessPolicy]()

