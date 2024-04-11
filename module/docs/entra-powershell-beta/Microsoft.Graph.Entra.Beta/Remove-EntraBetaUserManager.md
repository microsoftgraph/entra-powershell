---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaUserManager

## SYNOPSIS
Removes a user's manager.

## SYNTAX

```
Remove-EntraBetaUserManager -ObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaUserManager cmdlet removes a user's manager in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Remove the manager of a user
```
PS C:\> $User = Get-EntraBetaUser -Top 1
PS C:\> Remove-EntraBetaUserManager -ObjectId $User.ObjectId
```

The first command gets a user by using the Get-EntraBetaUser (./Get-EntraBetaUser.md)cmdlet, and then stores it in the $User variable.

The second command removes the user in $User.

## PARAMETERS



### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Azure AD.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUserManager]()

[Set-EntraBetaUserManager]()

