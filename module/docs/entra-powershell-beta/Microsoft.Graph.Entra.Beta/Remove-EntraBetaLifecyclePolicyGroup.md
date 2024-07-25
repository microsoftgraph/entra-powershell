---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaLifecyclePolicyGroup

schema: 2.0.0
---

# Remove-EntraBetaLifecyclePolicyGroup

## Synopsis
Removes a group from a lifecycle policy

## Syntax

```
Remove-EntraBetaLifecyclePolicyGroup -Id <String> -GroupId <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaLifecyclePolicyGroup cmdlet removes a group from a lifecycle policy in Azure Active Directory

## Examples

### Example 1
```
PS C:\> Remove-EntraBetaLifecyclePolicyGroup -Id b4c908b0-3595-4add-91b4-c5400b31b57b -groupId cffd97bd-6b91-4c4e-b553-6918a320211c
```

This command removes a group from a lifecycle policy in Azure Active Directory

## Parameters

### -GroupId
Specifies the ID of a group in Azure Active Directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the ID of the lifecycle policy object in Azure Active Directory.

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
