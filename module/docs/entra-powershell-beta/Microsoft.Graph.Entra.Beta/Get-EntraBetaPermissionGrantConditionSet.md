---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaPermissionGrantConditionSet

schema: 2.0.0
---

# Get-EntraBetaPermissionGrantConditionSet

## Synopsis
Get an Azure Active Directory permission grant condition set by id.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaPermissionGrantConditionSet
 -ConditionSetType <String>
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPermissionGrantConditionSet
 -Id <String>
 -ConditionSetType <String>
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description
Get an Azure Active Directory permission grant condition set object by id.

## Examples

### Example 1: Get all permission grant condition sets that are included in the permission grant policy
```
PS C:\>Get-EntraBetaPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes"
```

### Example 2: Get all permission grant condition sets that are excluded in the permission grant policy
```
PS C:\>Get-EntraBetaPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes"
```

### Example 3: Get a permission grant condition set
```
PS C:\>Get-EntraBetaPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
```

## Parameters

### -PolicyId
The unique identifier of an Azure Active Directory permission grant policy object.

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
The unique identifier of an Azure Active Directory permission grant condition set object.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### string
### string
### string
## Outputs

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet
## Notes

## Related Links

[New-EntraBetaPermissionGrantConditionSet]()

[Set-EntraBetaPermissionGrantConditionSet]()

[Remove-EntraBetaPermissionGrantConditionSet]()

