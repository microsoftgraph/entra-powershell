---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaServicePrincipalPolicy

## SYNOPSIS

## SYNTAX

```
Get-EntraBetaServicePrincipalPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaServicePrincipalPolicy cmdlet gets the policy of a service principal in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Get a policy
```
PS C:\>Get-EntraBetaServicePrincipalPolicy -Id "<object id of service principal>"
```

This command get the policy for the specified service principal.

## PARAMETERS



### -Id
The ID of the Service Principal for which you want to retrieve the policy

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

[Add-EntraBetaServicePrincipalPolicy]()

[Remove-EntraBetaServicePrincipalPolicy]()

