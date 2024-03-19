---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserOAuth2PermissionGrant

## SYNOPSIS
Gets an oAuth2PermissionGrant object.

## SYNTAX

```
Get-EntraUserOAuth2PermissionGrant [-All <Boolean>] -ObjectId <String> [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserOAuth2PermissionGrant cmdlet gets an oAuth2PermissionGrant object for the specified user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the OAuth2 permission grants for a user
```
PS C:\> $UserId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Get-EntraUserOAuth2PermissionGrant -ObjectId $UserId
```

The first command gets the ID of an Azure AD user by using the Get-EntraUser (./Get-EntraUser.md)cmdlet. 
The command stores the value in the $UserId variable.

The second command gets the OAuth2 permission grants for the user identified by $UserId.

## PARAMETERS

### -All
If true, return all permission grants.
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
Specifies the ID (as a UPN or ObjectId) of a user in Azure AD.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUser]()

