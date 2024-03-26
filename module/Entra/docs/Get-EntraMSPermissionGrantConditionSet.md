---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSPermissionGrantConditionSet

## SYNOPSIS
Get a Microsoft Entra ID permission grant condition set by id.

## SYNTAX

### GetQuery (Default)
```
Get-EntraMSPermissionGrantConditionSet -ConditionSetType <String> -PolicyId <String> [<CommonParameters>]
```

### GetById
```
Get-EntraMSPermissionGrantConditionSet -ConditionSetType <String> -Id <String> -PolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Get a Microsoft Entra ID permission grant condition set object by id.

## EXAMPLES

### Example 1: Get all permission grant condition sets that are included in the permission grant policy
```
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes"
```

### Example 2: Get all permission grant condition sets that are excluded in the permission grant policy
```
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes"
```

### Example 3: Get a permission grant condition set
```
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
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
Parameter Sets: GetById
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

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet
## NOTES

## RELATED LINKS

[New-EntraMSPermissionGrantConditionSet]()

[Set-EntraMSPermissionGrantConditionSet]()

[Remove-EntraMSPermissionGrantConditionSet]()

