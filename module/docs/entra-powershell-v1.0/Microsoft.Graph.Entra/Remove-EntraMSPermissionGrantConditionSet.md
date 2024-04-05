---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSPermissionGrantConditionSet

## SYNOPSIS
Delete a Microsoft Entra ID permission grant condition set by id

## SYNTAX

```
Remove-EntraMSPermissionGrantConditionSet -ConditionSetType <String> -Id <String> -PolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Microsoft Entra ID permission grant condition set object by id.

## EXAMPLES

### Example 1: Delete a permission grant condition set from a policy
```
PS C:\>Remove-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
```

## PARAMETERS

### -PolicyId
The unique identifier of a Microsoft Entra ID permission grant policy object.

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

### -ConditionSetType
The value indicates whether the condition sets are included in the policy or excluded.

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
The unique identifier of a Microsoft Entra ID permission grant condition set object.

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

### string
### string
### string
## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraMSPermissionGrantConditionSet]()

[Get-EntraMSPermissionGrantConditionSet]()

[Set-EntraMSPermissionGrantConditionSet]()

