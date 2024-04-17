---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaDirectoryRoleMember

## SYNOPSIS
Removes a member of a directory role.

## SYNTAX

```
Remove-EntraBetaDirectoryRoleMember -ObjectId <String> -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaDirectoryRoleMember cmdlet removes a member from a directory role in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Remove a member from a directory role
```
PS C:\>Remove-EntraBetaDirectoryRoleMember -ObjectId "019ea7a2-1613-47c9-81cb-20ba35b1ae48" -MemberId "c13dd34a-492b-4561-b171-40fcce2916c5"
```

This command removes the specified member from the specified role.

## PARAMETERS



### -MemberId
Specifies the object ID of a role member.

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

### -ObjectId
Specifies the object ID of a directory role in Azure AD.

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

[Add-EntraBetaDirectoryRoleMember]()

[Get-EntraBetaDirectoryRoleMember]()

