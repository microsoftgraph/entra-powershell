---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaServicePrincipalPolicy

## SYNOPSIS
Adds a service principal policy.

## SYNTAX

```
Add-EntraBetaServicePrincipalPolicy -Id <String> -RefObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaServicePrincipalPolicy cmdlet adds a service principal policy.

## EXAMPLES

### Example 1: Add a service principal policy
```
PS C:\>Add-EntraBetaServicePrincipalPolicy -Id <object id of service principal> -RefObjectId <object id of policy>
```

## PARAMETERS



### -RefObjectId
Specifies the object Id of the policy.

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

### -Id
The ID of the Service Principal for which you need to set the policy

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

[Get-EntraBetaServicePrincipalPolicy]()

[Remove-EntraBetaServicePrincipalPolicy]()

