---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSConditionalAccessPolicy

## SYNOPSIS
Gets a Microsoft Entra ID conditional access policy.

## SYNTAX

### GetQuery (Default)
```
Get-EntraMSConditionalAccessPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraMSConditionalAccessPolicy -PolicyId <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to get the Microsoft Entra ID conditional access policy.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Retrieves a list of all conditional access policies in Azure AD.
```
PS C:\> Get-EntraMSConditionalAccessPolicy

          Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
          DisplayName             : Demo app for documentation
          CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
          State                   : Disabled
```

This command retrieves a list of all conditional access policies in Azure AD.

### Example 2: Retrieves a conditional access policy in Azure AD with given Id.
```
PS C:\> Get-EntraMSConditionalAccessPolicy -PolicyId "6b5e999b-0ba8-4186-a106-e0296c1c4358"

          Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
          DisplayName             : Demo app for documentation
          CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
          ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
          State                   : Disabled
```

This command retrieves a conditional access policy in Azure AD.

## PARAMETERS

### -PolicyId
Specifies the ID of a conditional access policy in Microsoft Entra ID.

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

[New-EntraMSConditionalAccessPolicy]()

[Set-EntraMSConditionalAccessPolicy]()

[Remove-EntraMSConditionalAccessPolicy]()

