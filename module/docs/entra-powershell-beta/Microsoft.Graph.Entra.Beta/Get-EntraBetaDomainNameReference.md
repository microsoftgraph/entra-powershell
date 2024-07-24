---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomainNameReference

schema: 2.0.0
---

# Get-EntraBetaDomainNameReference

## Synopsis
This cmdlet retrieves the objects that are referenced by a given domain name

## Syntax

```
Get-EntraBetaDomainNameReference -Name <String> [<CommonParameters>]
```

## Description
This cmdlet retrieves the objects that are referenced by a given domain name

## Examples

### Example 1
```
PS C:\WINDOWS\system32> Get-EntraBetaDomainNameReference -Name drumkit.onmicrosoft.com
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter

## Parameters

### -Name
The name of the domain name for which the referenced objects are retrieved

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

### System.String
## Outputs

### System.Object
## Notes

## Related Links
