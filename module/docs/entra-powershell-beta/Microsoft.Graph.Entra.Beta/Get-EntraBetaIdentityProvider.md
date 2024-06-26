---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaIdentityProvider

## Synopsis
This cmdlet is used to retrieve the configured identity providers in the directory.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaIdentityProvider [<CommonParameters>]
```

### GetById
```
Get-EntraBetaIdentityProvider -Id <String> [<CommonParameters>]
```

## Description
This cmdlet is used to retrieve the identity providers that have been configured in the directory.
These identity providers can be used to allow users to sign up for or sign into applications secured by Azure AD B2C.

Configuring an identity provider in your Azure AD tenant also enables future B2B guest scenarios.
For example, an organization has resources in Office 365 that needs to be shared with a Gmail user.
The Gmail user will use their Google account credentials to authenticate and access the documents.

The current set of identity providers can be Microsoft, Google, Facebook, Amazon, or LinkedIn.

## Examples

### Example 1
```
PS C:\> Get-EntraBetaIdentityProvider
```

This example retrieves the list of all configured identity providers and their properties.

### Example 2
```
PS C:\> Get-EntraBetaIdentityProvider -Id LinkedIn-OAUTH
```

This example retrieves the properties for the identity provider specified.

## Parameters

### -Id
The unique identifier for an identity provider.

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

### System.String
## Outputs

### System.Object
## Notes

## Related Links
