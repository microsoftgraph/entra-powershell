---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Reset-EntraMSLifeCycleGroup

## SYNOPSIS
Renews a group by updating the RenewedDateTime property on a group to the current DateTime.

## SYNTAX

```
Reset-EntraMSLifeCycleGroup -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Reset-EntraMSLifeCycleGroup renews a group by updating the RenewedDateTime property on a group to the current DateTime.
When a group is renewed, the group expiration is extended by the number of days defined in the policy.

## EXAMPLES

### Example 1
```
PS C:\> Reset-EntraMSLifeCycleGroup -groupId cffd97bd-6b91-4c4e-b553-6918a320211c
```

The Reset-EntraMSLifeCycleGroup renews a specified group by updating the RenewedDateTime property on a group to the current DateTime.

## PARAMETERS

### -Id
{{ Fill Id Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
