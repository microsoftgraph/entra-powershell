---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaScopedRoleMembership

## SYNOPSIS
Gets a scoped role membership from an administrative unit.

## SYNTAX

```
Get-EntraBetaScopedRoleMembership -ObjectId <String> [-ScopedRoleMembershipId <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaScopedRoleMembership cmdlet gets a scoped role membership from an administrative unit in Azure Active Directory (AD).

## EXAMPLES

### Example 1 Get Scoped Role Administrator
```
PS C:\>Get-EntraBetaScopedRoleMembership -ObjectId "526b7173-5a6e-49dc-88ec-b677a9093709" -ScopedRoleMembershipId "356b7173-5a6e-49dc-88ec-b677a9093709"
```

### Example 2 List scoped administrators for AU.
```
PS C:\>Get-EntraBetaScopedRoleMembership -ObjectId "526b7173-5a6e-49dc-88ec-b677a9093709"
```

## PARAMETERS

### -ObjectId
Specifies the ID of an object.

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

### -ScopedRoleMembershipId
Specifies the ID of a scoped role membership.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaScopedRoleMembership]()

[Remove-EntraBetaScopedRoleMembership]()

