---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaApplicationPolicy

## SYNOPSIS
The Add-EntraBetaApplicationPolicy cmdlet is not available at this time .

## SYNTAX

```
Add-EntraBetaApplicationPolicy -Id <String> -RefObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaApplicationPolicy cmdlet adds an Azure Active Directory application policy.

## EXAMPLES

### Example 1: Add an application policy
```
PS C:\>Add-EntraBetaApplicationPolicy -ObjectId <object id of application> -RefObjectId <object id of policy>
```

This command adds an application policy.

## PARAMETERS


### -RefObjectId
Specifies the ID of the policy.

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
The ID of the application for which you need to set the policy

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

[Get-EntraBetaApplicationPolicy]()

[Remove-EntraBetaApplicationPolicy]()

