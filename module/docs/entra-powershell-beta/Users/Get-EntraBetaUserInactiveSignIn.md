---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserInactiveSignIn command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 11/08/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserInactiveSignIn
schema: 2.0.0
title: Get-EntraBetaUserInactiveSignIn
---

# Get-EntraBetaUserInactiveSignIn

## SYNOPSIS

Retrieve users without interactive sign-ins in the last N days.

## SYNTAX

```powershell
Get-EntraBetaUserInactiveSignIn
 -Ago <Int32>
 [-UserType <String>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet retrieves users without interactive sign-ins in the last N days.

## EXAMPLES

### Example 1: Retrieve users without interactive sign-ins in the last 10 days

```powershell
Connect-Entra -Scopes 'User.Read.All','AuditLog.Read.All'
Get-EntraBetaUserInactiveSignIn -Ago 10
```

```Output
UserID                            : cccccccc-2222-3333-4444-dddddddddddd
DisplayName                       : Allan Deyoung
UserPrincipalName                 : AllanD@Contoso.com
Mail                              : AllanD@Contoso.com
UserType                          : Member
AccountEnabled                    : True
LastSignInDateTime                : 10/7/2024 12:15:17 PM
LastSigninDaysAgo                 : 30
lastSignInRequestId               : eeeeeeee-4444-5555-6666-ffffffffffff
lastNonInteractiveSignInDateTime  : 10/7/2024 12:13:13 PM
LastNonInteractiveSigninDaysAgo   : 30
lastNonInteractiveSignInRequestId : dddddddd-3333-4444-5555-eeeeeeeeeeee
CreatedDateTime                   : 10/7/2024 12:32:30 AM
CreatedDaysAgo                    : 31
```

This example shows how to find users who haven’t signed in within the past 30 days.

### Example 2: Retrieve guest users without interactive sign-ins in the last 10 days

```powershell
Connect-Entra -Scopes 'User.Read.All','AuditLog.Read.All'
Get-EntraBetaUserInactiveSignIn -Ago 10 -UserType 'Guest'
```

```Output
UserID                            : cccccccc-2222-3333-4444-dddddddddddd
DisplayName                       : Allan Deyoung
UserPrincipalName                 : AllanD@Contoso.com
Mail                              : AllanD@Contoso.com
UserType                          : Guest
AccountEnabled                    : True
LastSignInDateTime                : 10/7/2024 12:15:17 PM
LastSigninDaysAgo                 : 30
lastSignInRequestId               : eeeeeeee-4444-5555-6666-ffffffffffff
lastNonInteractiveSignInDateTime  : 10/7/2024 12:13:13 PM
LastNonInteractiveSigninDaysAgo   : 30
lastNonInteractiveSignInRequestId : dddddddd-3333-4444-5555-eeeeeeeeeeee
CreatedDateTime                   : 10/7/2024 12:32:30 AM
CreatedDaysAgo                    : 31
```

This example shows how to find guest users who haven’t signed in within the past 30 days. Choose `All` for all users, `Member` for internal users, or `Guest` for external users.

### Example 3: Retrieve Users Without Interactive Sign-Ins in the Last 10 Days Using a Filter

```powershell
Connect-Entra -Scopes 'User.Read.All','AuditLog.Read.All'
Get-EntraBetaUserInactiveSignIn -Ago 10 | Where-Object {$_.UserPrincipalName -eq 'SawyerM@contoso.com'}
```

```Output
UserID                            : cccccccc-2222-3333-4444-dddddddddddd
DisplayName                       : Sawyer Miller
UserPrincipalName                 : SawyerM@Contoso.com
Mail                              : SawyerM@Contoso.com
UserType                          : Member
AccountEnabled                    : True
LastSignInDateTime                : 10/7/2024 12:15:17 PM
LastSigninDaysAgo                 : 30
lastSignInRequestId               : eeeeeeee-4444-5555-6666-ffffffffffff
lastNonInteractiveSignInDateTime  : 10/7/2024 12:13:13 PM
LastNonInteractiveSigninDaysAgo   : 30
lastNonInteractiveSignInRequestId : dddddddd-3333-4444-5555-eeeeeeeeeeee
CreatedDateTime                   : 10/7/2024 12:32:30 AM
CreatedDaysAgo                    : 31
```

This example shows how to find users who haven’t signed in within the past 30 days using a filter.

## PARAMETERS

### -Ago

Number of days to check for Last Sign In Activity.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: LastSignInBeforeDaysAgo

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserType

Specifies the type of user to filter. Choose `All` for all users, `Member` for internal users, or `Guest` for external users.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

Updating Role Assignable Groups or Privileged Access Groups require `PrivilegedAccess.ReadWrite.AzureADGroup` permission scope.

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)
