---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Reset-EntraBetaLifeCycleGroup

## Synopsis
renews a group by updating the RenewedDateTime property on a group to the current DateTime.

## Syntax

```
Reset-EntraBetaLifeCycleGroup -GroupId <String> [<CommonParameters>]
```

## Description
the Reset-EntraBetaLifeCycleGroup renews a group by updating the RenewedDateTime property on a group to the current DateTime.
When a group is renewed, the group expiration is extended by the number of days defined in the policy.

## Examples

### Example 1
```
PS C:\> Reset-EntraBetaLifeCycleGroup -groupId cffd97bd-6b91-4c4e-b553-6918a320211c
```

The Reset-EntraBetaLifeCycleGroup renews a specified group by updating the RenewedDateTime property on a group to the current DateTime.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None
## Outputs

### System.Object
## Notes

## Related Links
