---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSAuthorizationPolicy

## Synopsis
Gets an authorization policy.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaMSAuthorizationPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSAuthorizationPolicy -Id <String> [<CommonParameters>]
```

## Description
The Get-EntraBetaMSAuthorizationPolicy cmdlet gets an Azure Active Directory authorization policy.

## Examples

### Example 1: Get an authorization policy by ID
```
PS C:\>Get-EntraBetaMSAuthorizationPolicy -Id "authorizationPolicy"
```

## Parameters

### -Id
Specifies the unique identifier of the authorization policy.

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

[Set-EntraBetaMSAuthorizationPolicy]()

