---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPasswordPolicy

## SYNOPSIS
Retrieves the current password policy for the tenant or the specified domain.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaPasswordPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaPasswordPolicy -DomainName <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaPasswordPolicy cmdlet can be used to retrieve the values associated with the Password Expiry
window or Password Expiry Notification window for a tenant or specified domain. 
When a domain name is
specified, it must be a verified domain for the company.

## EXAMPLES

### EXAMPLE 1
```
Get-EntraBetaPasswordPolicy -DomainName contoso.com
```

Returns the password policy.

Description

-----------

Returns the password policy for the domain contoso.com.

## PARAMETERS

### -DomainName
The fully qualified name of the domain to be retrieved.

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
