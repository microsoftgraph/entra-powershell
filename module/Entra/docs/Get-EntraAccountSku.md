---
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAccountSku

## SYNOPSIS
Retrieves all the SKUs for a company.

## SYNTAX

### GetQuery (Default)
```
Get-EntraAccountSku [<CommonParameters>]
```

### GetById
```
Get-EntraAccountSku [-TenantId <Guid>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraAccountSku will return all the SKUs that the company owns.

## EXAMPLES

### EXAMPLE 1
```
Get-EntraAccountSku
```

Description

-----------

This command returns a list of SKUs.

## PARAMETERS

### -TenantId
The unique ID of the tenant to perform the operation on.
If this is not provided then the value will default to
the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
