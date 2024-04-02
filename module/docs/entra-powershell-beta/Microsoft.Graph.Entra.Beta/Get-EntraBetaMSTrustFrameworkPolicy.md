---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSTrustFrameworkPolicy

## SYNOPSIS
This cmdlet is used to retrieve the created trust framework policies (custom policies) in the directory.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSTrustFrameworkPolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSTrustFrameworkPolicy -Id <String> [-OutputFilePath <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to retrieve the trust framework policies that have been created in the directory.

## EXAMPLES

### Example 1
```
PS C:\> Get-EntraBetaMSTrustFrameworkPolicy
```

This example retrieves the list of all trust framework policies in the directory.

### Example 2
```
PS C:\> Get-EntraBetaMSTrustFrameworkPolicy -Id B2C_1A_signup_signin
```

This example retrieves the contents of the specified trust framework policy.

## PARAMETERS

### -Id
The unique identifier for a trust framework policy.

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

### -OutputFilePath
@{Description=System.Management.Automation.PSObject\[\]}

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
