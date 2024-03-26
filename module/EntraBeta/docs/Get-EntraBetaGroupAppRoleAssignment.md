---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupAppRoleAssignment

## SYNOPSIS
Gets a group application role assignment.

## SYNTAX

```
Get-EntraBetaGroupAppRoleAssignment -ObjectId <String> [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaGroupAppRoleAssignment cmdlet gets a group application role assignment in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Retrieve application role assignments of a group
```
$GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
Get-EntraBetaGroupAppRoleAssignment -ObjectId $GroupId
```

The first command gets the object ID of a group by using the Get-EntraBetaGroup (./Get-EntraBetaGroup.md)cmdlet.
The command stores the ID in the $GroupId variable.

The second command gets the application role assignments of the group in $GroupId.

## PARAMETERS

### -All
If true, return all application role assignments.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a group in Azure AD.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaGroup]()

[New-EntraBetaGroupAppRoleAssignment]()

[Remove-EntraBetaGroupAppRoleAssignment]()

