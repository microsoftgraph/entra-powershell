---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationPolicy

## SYNOPSIS
Gets an application policy.

## SYNTAX

```
Get-EntraBetaApplicationPolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaApplicationPolicy cmdlet gets an Azure Active Directory application policy.

## EXAMPLES

### Example 1: Get an application policy
```
PS C:\>Get-EntraBetaApplicationPolicy -Id "<object id of application>"
```

This command gets the specified application policy.

## PARAMETERS

### -Id
The ID of the application for which you need to retrieve the policy

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

[Add-EntraBetaApplicationPolicy]()

[Remove-EntraBetaApplicationPolicy]()

