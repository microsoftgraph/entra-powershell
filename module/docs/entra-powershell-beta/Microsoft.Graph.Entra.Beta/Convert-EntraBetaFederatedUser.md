---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Convert-EntraBetaFederatedUser

## SYNOPSIS
Updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

## SYNTAX

```
Convert-EntraBetaFederatedUser [-UserPrincipalName] <String> [[-NewPassword] <String>] [[-TenantId] <Guid>]
 [<CommonParameters>]
```

## DESCRIPTION
The Convert-EntraBetaFederatedUser cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to
standard authentication type. 
A new password must be provided for the user.

## EXAMPLES

### EXAMPLE 1
```
Convert-EntraBetaFederatedUser -UserPrincipalName "pattifuller@contoso.com"
```

## PARAMETERS

### -UserPrincipalName
The Microsoft Azure Active Directory UserID for the user to convert.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword
The new password of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId
The unique ID of the tenant to perform the operation on. 
If this is not provided then it will default to the tenant of the current user. 
This parameter is only
applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
