---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaAccountSku

schema: 2.0.0
---

# Get-EntraBetaAccountSku

## Synopsis
Retrieves all the SKUs for a company.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaAccountSku [<CommonParameters>]
```

### GetById
```
Get-EntraBetaAccountSku [-TenantId <Guid>] [<CommonParameters>]
```

## Description
The Get-EntraBetaAccountSku will return all the SKUs that the company owns.

## Examples

### Example 1
```
Get-EntraBetaAccountSku
```

Description

-----------

This command returns a list of SKUs.

## Parameters

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
