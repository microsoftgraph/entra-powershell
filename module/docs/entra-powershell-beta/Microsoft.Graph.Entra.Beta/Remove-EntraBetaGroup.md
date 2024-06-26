---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaGroup

## Synopsis
removes a group.

## Syntax

```
Remove-EntraBetaGroup -ObjectId <String> [<CommonParameters>]
```

## Description
the Remove-EntraBetaGroup cmdlet removes a group from Azure Active Directory (AD).
Note that a Unified Group can be restored withing 30 days after deletion using the Restore-EntraBetaDeletedDirectoryObject cmdlet.
Security groups cannot be restored after deletion.

## Examples

### Example 1: Remove a group
```
PS C:\>Remove-EntraBetaGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606"
```

This command removes the specified group from Azure AD.

## Parameters



### -ObjectId
Specifies the object ID of a group in Azure AD.

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

[Get-EntraBetaGroup]()

[New-EntraBetaGroup]()

[Set-EntraBetaGroup]()

