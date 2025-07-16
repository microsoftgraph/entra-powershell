---
author: msewaweru
description: This article provides details on the Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport command.
external help file: Microsoft.Entra.Beta.Reports-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 03/23/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport
schema: 2.0.0
title: Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport
---

# Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport

## SYNOPSIS

List the user's registered authentication methods.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Sort <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport
 -UserRegistrationDetailsId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport` cmdlet lists the user's registered authentication methods from the `userRegistrationDetails` object. This method doesn't work for disabled accounts (user accounts).

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles support this operation:

- Reports Reader
- Security Reader
- Security Administrator
- Global Reader

## EXAMPLES

### Example 1: Get all user's registered authentication methods

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -All | Format-Table -AutoSize
```

```Output
Id                                   IsAdmin IsMfaCapable IsMfaRegistered IsPasswordlessCapable IsSsprCapable 
--                                   ------- ------------ --------------- --------------------- -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb True    False        False           False                 True      
bbbbbbbb-1111-2222-3333-cccccccccccc False   False        False           False                 False     
cccccccc-2222-3333-4444-dddddddddddd False   False        False           False                 False     
dddddddd-3333-4444-5555-eeeeeeeeeeee False   False        False           False                 False 
```

This example demonstrates how to retrieve all the user's registered authentication methods.

### Example 2: Get user's registered authentication methods by UserRegistrationDetailsId

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
isMfaRegistered                               : False
@odata.context                                : https://graph.microsoft.com/beta/$metadata#reports/authenticationMethods/userRegistrationDetails(*)/$entity
userPrincipalName                             : sawyermiller@contoso.com
isSystemPreferredAuthenticationMethodEnabled  : True
id                                            : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
isSsprRegistered                              : False
isSsprEnabled                                 : False
userDisplayName                               : Sawyer Miller
lastUpdatedDateTime                           : 3/16/2025 7:55:54 AM
userType                                      : member
isAdmin                                       : False
methodsRegistered                             : {}
systemPreferredAuthenticationMethods          : {}
userPreferredMethodForSecondaryAuthentication : none
isPasswordlessCapable                         : False
isSsprCapable                                 : False
isMfaCapable                                  : False
```

This example shows how to retrieve a specific user's registered authentication methods by `UserRegistrationDetailsId`.

- `-UserRegistrationDetailsId` parameter specifies the user's registered authentication methods.

### Example 3: Get user's registered authentication methods with filtering

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -Filter "userType eq 'member'" | Format-Table -AutoSize
```

```Output
Id                                   IsAdmin IsMfaCapable IsMfaRegistered IsPasswordlessCapable IsSsprCapable 
--                                   ------- ------------ --------------- --------------------- -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb True    False        False           False                 True      
bbbbbbbb-1111-2222-3333-cccccccccccc False   False        False           False                 False     
cccccccc-2222-3333-4444-dddddddddddd False   False        False           False                 False     
dddddddd-3333-4444-5555-eeeeeeeeeeee False   False        False           False                 False 
```

This example demonstrates how to retrieve a user's registered authentication methods with filtering `userType` property.

### Example 4: Retrieve user's registered authentication methods properties

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -Property id, userDisplayName, userType, isMfaRegistered, isPasswordlessCapable | Format-Table -AutoSize
```

```Output
Id                                   UserDisplayName   UserType IsMfaRegistered IsPasswordlessCapable
--                                   ---------------   -------- ---------------- ---------------------
cccccccc-2222-3333-4444-dddddddddddd Angel Brown       member   True             False
dddddddd-3333-4444-5555-eeeeeeeeeeee Alex Wilber       member   False            False
eeeeeeee-4444-5555-6666-ffffffffffff Avery Smith       member   False            False
bbbbbbbb-1111-2222-3333-cccccccccccc Christie Cline    member   False            False
aaaaaaaa-bbbb-cccc-1111-222222222222 Patti Fernandez   member   False            False
```

This example demonstrates how to retrieve a user's registered authentication methods. You can use `-Select` as an alias for `-Property`.

### Example 5: Get a list of recently updated user's registered authentication methods details using 'sort'

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -All -Sort 'lastUpdatedDateTime desc' -Limit 4 | Format-Table -AutoSize
```

```Output
Id                                   IsAdmin IsMfaCapable IsMfaRegistered IsPasswordlessCapable IsSsprCapable 
--                                   ------- ------------ --------------- --------------------- -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb True    False        False           False                 True 
```

This example shows how to get one detail about the user's registered authentication methods. You can use `-OrderBy` or `-SortBy` as an alias for `-Sort`.

### Example 6: Get a single result

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All'
Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport -Top 1 | Format-Table -AutoSize
```

```Output
Id                                   IsAdmin IsMfaCapable IsMfaRegistered IsPasswordlessCapable IsSsprCapable 
--                                   ------- ------------ --------------- --------------------- -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb True    False        False           False                 True 
```

This example shows how to get one detail about the user's registered authentication methods. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

### -UserRegistrationDetailsId

Specifies the user object identifier in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: False (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies an OData v4.0 filter statement.
This parameter filters which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Sort

This parameter sorts the results by property.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: SortBy, OrderBy

Required: False
Position: Named
Default value: None
Accept pipeline input: False (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### isAdmin (Boolean)

Shows whether the user has an admin role in the tenant. Use it to check which authentication methods privileged accounts register and use.

### isMfaCapable (Boolean)

Indicates that the user uses a strong MFA method allowed by the authentication methods policy. Supports `$filter (eq)`.

### isMfaRegistered (Boolean)

Indicates whether the user registers a strong MFA method, even if the authentication methods policy doesn't allow it. Supports `$filter (eq)`.

### isPasswordlessCapable (Boolean)

Shows if the user registers a passwordless strong authentication method—like FIDO2, Windows Hello for Business, or Microsoft Authenticator—that the policy allows. Supports `$filter (eq)`.

### isSsprCapable (Boolean)

Shows if the user has registered enough methods and is allowed to use self-service password reset based on policy. Supports `$filter (eq)`.

### isSsprEnabled (Boolean)

Shows if the user is allowed to use self-service password reset by policy, even if they haven’t registered enough authentication methods. Supports `$filter (eq)`.

### isSsprRegistered (Boolean)

Shows if the user registers enough authentication methods for self-service password reset, even if the policy doesn't allow them to use it. Supports `$filter (eq)`.

### isSystemPreferredAuthenticationMethodEnabled (Boolean)

Shows if system-preferred authentication is on. When enabled, the system selects the most secure method from the ones the user registers. Supports `$filter (eq)`.

### lastUpdatedDateTime (DateTimeOffset)

The date and time (in UTC) when the report was last updated, in ISO 8601 format. For example, midnight UTC on Jan 1, 2014 is shown as `2014-01-01T00:00:00Z`.

### methodsRegistered (String collection)

List of registered authentication methods, like mobilePhone, email, or passKeyDeviceBound. Supports `$filter` with `any` and `eq`.

### systemPreferredAuthenticationMethods (String collection)

List of the most secure second-factor authentication methods chosen by the system from the user's registered methods. Values include: push, oath, voiceMobile, voiceAlternateMobile, voiceOffice, sms, none. Supports `$filter` with `any` and `eq`.

### userDisplayName (String)

The user's display name, like "Sawyer Miller." Supports `$filter` (`eq`, `startsWith`) and `$orderby`.

### userPreferredMethodForSecondaryAuthentication (userDefaultAuthenticationMethod)

The user's chosen default method for second-factor authentication. Options include: push, oath, voiceMobile, voiceAlternateMobile, voiceOffice, sms, none. Used as the preferred MFA method when system-preferred authentication is off. Supports `$filter` with `any` and `eq`.

### userPrincipalName (String)

The user's sign-in name, like SawyerM@contoso.com. Supports `$filter` (`eq`, `startsWith`) and `$orderby`.

### userType (signInUserType)

Shows if the user is a member or guest in the tenant. Values: member, guest.

## NOTES

`Get-EntraBetaAuthMethodUserRegistrationDetailReport` is an alias for `Get-EntraBetaAuthenticationMethodUserRegistrationDetailReport`.

## RELATED LINKS
