---
title: Get-EntraBetaUserOwnedObject
description: This article provides details on the Get-EntraBetaUserOwnedObject command.


ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserOwnedObject

schema: 2.0.0
---

# Get-EntraBetaUserOwnedObject

## Synopsis

Get objects owned by a user.

## Syntax

```powershell
Get-EntraBetaUserOwnedObject 
 -ObjectId <String>
 [-Top <Int32>] 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserOwnedObject` cmdlet gets objects owned by a user in Microsoft Entra ID.
Specify `ObjectId` parameter to retrieve objects owned by a user.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
description                       :
id                                : bbbbbbbb-1111-2222-3333-cccccccccccc
optionalClaims                    :
verifiedPublisher                 : @{verifiedPublisherId=; displayName=; addedDateTime=}
isManagementRestricted            :
keyCredentials                    : {}
samlMetadataUrl                   :
deletedDateTime                   :
web                               : @{homePageUrl=https://localhost/demoapp; implicitGrantSettings=; redirectUriSettings=System.Object[]; redirectUris=System.Object[];
                                    logoutUrl=}
groupMembershipClaims             :
publisherDomain                   : contoso.com
@odata.type                       : #microsoft.graph.application
identifierUris                    : {}
servicePrincipalLockConfiguration :
migrationStatus                   :
passwordCredentials               : {}
tags                              : {}
notes                             :
appRoles                          : {@{allowedMemberTypes=Application; value=saml; isPrivate=False; id=ab8b23a1-b912-4134-9f8d-6cb3fddcd890; description=Specifies the
                                    preferred single sign-on mode for the application; displayName=Preferred Single Sign-On Mode; isEnabled=True; origin=Application;
                                    isPreAuthorizationRequired=False}}
```

This example retrieves objects owned by the specified user.

- `-ObjectId` parameter specifies the user ID.

### Example 2: Get all objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All
```

```Output
description                       :
id                                : bbbbbbbb-1111-2222-3333-cccccccccccc
optionalClaims                    :
verifiedPublisher                 : @{verifiedPublisherId=; displayName=; addedDateTime=}
isManagementRestricted            :
keyCredentials                    : {}
samlMetadataUrl                   :
deletedDateTime                   :
web                               : @{homePageUrl=https://localhost/demoapp; implicitGrantSettings=; redirectUriSettings=System.Object[]; redirectUris=System.Object[];
                                    logoutUrl=}
groupMembershipClaims             :
publisherDomain                   : contoso.com
@odata.type                       : #microsoft.graph.application
identifierUris                    : {}
servicePrincipalLockConfiguration :
migrationStatus                   :
passwordCredentials               : {}
tags                              : {}
notes                             :
appRoles                          : {@{allowedMemberTypes=Application; value=saml; isPrivate=False; id=ab8b23a1-b912-4134-9f8d-6cb3fddcd890; description=Specifies the
                                    preferred single sign-on mode for the application; displayName=Preferred Single Sign-On Mode; isEnabled=True; origin=Application;
                                    isPreAuthorizationRequired=False}}
```

This example retrieves all the objects owned by the specified user.

- `-ObjectId` parameter specifies the user ID.

### Example 3: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 3
```

```Output
description                       :
id                                : bbbbbbbb-1111-2222-3333-cccccccccccc
optionalClaims                    :
verifiedPublisher                 : @{verifiedPublisherId=; displayName=; addedDateTime=}
isManagementRestricted            :
keyCredentials                    : {}
samlMetadataUrl                   :
deletedDateTime                   :
web                               : @{homePageUrl=https://localhost/demoapp; implicitGrantSettings=; redirectUriSettings=System.Object[]; redirectUris=System.Object[];
                                    logoutUrl=}
groupMembershipClaims             :
publisherDomain                   : contoso.com
@odata.type                       : #microsoft.graph.application
identifierUris                    : {}
servicePrincipalLockConfiguration :
migrationStatus                   :
passwordCredentials               : {}
tags                              : {}
notes                             :
appRoles                          : {@{allowedMemberTypes=Application; value=saml; isPrivate=False; id=ab8b23a1-b912-4134-9f8d-6cb3fddcd890; description=Specifies the
                                    preferred single sign-on mode for the application; displayName=Preferred Single Sign-On Mode; isEnabled=True; origin=Application;
                                    isPreAuthorizationRequired=False}}
```

This example retrieves the top three objects owned by the specified user.

- `-ObjectId` parameter specifies the user ID.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId

Specifies the ID of a user (as a User Principal Name or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
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
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
