---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Add-EntraBetaApplicationPolicy

## Synopsis
The Add-EntraBetaApplicationPolicy cmdlet is not available at this time .

## Syntax

```
Add-EntraBetaApplicationPolicy -Id <String> -RefObjectId <String> [<CommonParameters>]
```

## Description
The Add-EntraBetaApplicationPolicy cmdlet Adds an Azure Active Directory application policy.

## Examples

### Example 1: Add an application policy
```
PS C:\>Add-EntraBetaApplicationPolicy -ObjectId <object id of application> -RefObjectId <object id of policy>
```

This command Adds an application policy.

## Parameters


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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaApplicationPolicy]()

[Remove-EntraBetaApplicationPolicy]()

