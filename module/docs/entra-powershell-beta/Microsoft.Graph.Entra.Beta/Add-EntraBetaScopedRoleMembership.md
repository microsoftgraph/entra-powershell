---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaScopedRoleMembership

## SYNOPSIS
Adds a scoped role membership to an administrative unit.

## SYNTAX

```
Add-EntraBetaScopedRoleMembership -ObjectId <String> [-RoleMemberInfo <RoleMemberInfo>]
 [-AdministrativeUnitObjectId <String>] [-RoleObjectId <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaScopedRoleMembership cmdlet adds a scoped role membership to an administrative unit.

## EXAMPLES

### Example 1
```
$User = Get-EntraBetaUser -SearchString "The user that will be an admin on this unit"
	$Role = Get-EntraBetaDirectoryRole | Where-Object -Property DisplayName -EQ -Value "User Account Administrator"
	$Unit = Get-EntraBetaAdministrativeUnit | Where-Object -Property DisplayName -Eq -Value "<The display name of the unit"
	$RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
	$RoleMember.ObjectId = $User.ObjectID
	Add-EntraBetaScopedRoleMembership -ObjectId $unit.ObjectId -RoleObjectId $Role.ObjectId -RoleMemberInfo $RoleMember
```

This cmdlet returns the Scope role membership object:

AdministrativeUnitObjectId           RoleObjectId 	--------------------------           ------------ 	c9ab56cc-e349-4237-856e-cab03157a91e 526b7173-5a6e-49dc-88ec-b677a9093709

## PARAMETERS

### -AdministrativeUnitObjectId
Specifies the ID of an admininstrative unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
@{Text=}

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

### -RoleMemberInfo
Specifies a RoleMemberInfo object.

```yaml
Type: RoleMemberInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleObjectId
@{Text=}

```yaml
Type: String
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaScopedRoleMembership]()

[Remove-EntraBetaScopedRoleMembership]()

