---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserOAuth2PermissionGrant

## Synopsis
Gets an oAuth2PermissionGrant object.

## Syntax

```
Get-EntraBetaUserOAuth2PermissionGrant -ObjectId <String> [-All] [-Top <Int32>] [<CommonParameters>]
```

## Description
The Get-EntraBetaUserOAuth2PermissionGrant cmdlet gets an oAuth2PermissionGrant object for the specified user in Azure Active Directory (AD).

## Examples

### Example 1: Retrieve the OAuth2 permission grants for a user
```
PS C:\> $UserId = (Get-EntraBetaUser -Top 1).ObjectId
PS C:\> Get-EntraBetaUserOAuth2PermissionGrant -ObjectId $UserId
```

The first command gets the ID of an Azure AD user by using the Get-EntraBetaUser (./Get-EntraBetaUser.md)cmdlet. 
The command stores the value in the $UserId variable.

The second command gets the OAuth2 permission grants for the user identified by $UserId.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraBetaUser]()

