---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaOAuth2PermissionGrant

## Synopsis
Removes an oAuth2PermissionGrant.

## Syntax

```
Remove-EntraBetaOAuth2PermissionGrant -ObjectId <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaOAuth2PermissionGrant cmdlet removes an oAuth2PermissionGrant object in Azure Active Directory (AD).

## Examples

### Example 1: Remove an OAuth2 permission grant
```
PS C:\> $SharePointSP = Get-EntraBetaServicePrincipal | Where-Object {$_.DisplayName -eq "Microsoft.SharePoint"}
PS C:\> $SharePointOA2AllSitesRead = Get-EntraBetaOAuth2PermissionGrant | Where-Object {$_.ResourceId -eq $SharePointSP.ObjectId} | Where-Object {$_.Scope -eq "AllSites.Read"}
PS C:\> Remove-EntraBetaOAuth2PermissionGrant -ObjectId $SharePointOA2AllSitesRead.ObjectId
```

The first command gets a service principal that matches the specified display name by using the Get-EntraBetaServicePrincipal (./Get-EntraBetaServicePrincipal.md)cmdlet. 
The command stores the result in the $SharePointSP variable.

The second command gets certain permission grants by using the Get-EntraBetaOAuth2PermissionGrant (./Get-EntraBetaOAuth2PermissionGrant.md)cmdlet. 
The command stores the result in the $SharePointOA2AllSitesRead variable.

The final command removes the permission grant in $SharePointOA2AllSitesRead.

## Parameters



### -ObjectId
Specifies the ID of an oAuth2PermissionGrant object in Azure AD.

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

[Get-EntraBetaOAuth2PermissionGrant]()

[Get-EntraBetaServicePrincipal]()

