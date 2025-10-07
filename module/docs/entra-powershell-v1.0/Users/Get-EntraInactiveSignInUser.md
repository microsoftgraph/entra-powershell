---
description: This article provides details on the Get-EntraInactiveSignInUser command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Users
ms.author: eunicewaweru
ms.date: 04/02/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Get-EntraInactiveSignInUser
schema: 2.0.0
title: Get-EntraInactiveSignInUser
---

# Get-EntraInactiveSignInUser

## SYNOPSIS

Retrieve users without an interactive sign-in since a specified number of days ago.

## SYNTAX

```powershell
Get-EntraInactiveSignInUser 
[-LastSignInBeforeDaysAgo <Int32>]
[-UserType <String>] 
[<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraInactiveSignInUser` cmdlet retrieves users who didn't sign in interactively within a specified number of days. This cmdlet can be useful for identifying inactive accounts in your Microsoft Entra ID environment.

## EXAMPLES

### Example 1: Retrieve users who didn't sign in for 30 days

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','User.Read.All'
Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30 -All
```

```Output
UserID                           : dddddddd-3333-4444-5555-eeeeeeeeeeee
DisplayName                      : John Doe
UserPrincipalName                : johndoe@contoso.onmicrosoft.com
Mail                             : johndoe@contoso.onmicrosoft.com
UserType                         : Member
AccountEnabled                   : True
LastSignInDateTime               : 03/02/2025 5:59:28 AM
LastSigninDaysAgo                : 30
lastSignInRequestId              : cccccccc-2222-3333-4444-dddddddddddd
lastNonInteractiveSignInDateTime : Unknown
LastNonInteractiveSigninDaysAgo  : Unknown
CreatedDateTime                  : 01/04/2025 5:55:34 AM
CreatedDaysAgo                   : 30

UserID                           : aaaaaaaaa-3333-4444-5555-eeeeeeeeeeee
DisplayName                      : Example User
UserPrincipalName                : example@contoso.onmicrosoft.com
Mail                             : example@contoso.onmicrosoft.com
UserType                         : Guest
AccountEnabled                   : True
LastSignInDateTime               : 03/02/2025 5:59:28 AM
LastSigninDaysAgo                : 30
lastSignInRequestId              : ddddddddd-2222-3333-4444-dddddddddddd
lastNonInteractiveSignInDateTime : Unknown
LastNonInteractiveSigninDaysAgo  : Unknown
CreatedDateTime                  : 01/04/2025 5:00:34 AM
CreatedDaysAgo                   : 30
```

This command retrieves users without an interactive sign-in within the last 30 days.

### Example 2: Retrieve inactive guest users

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','User.Read.All'
Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 90 -UserType "Guest"
```

```Output
UserID                           : dddddddd-3333-4444-5555-eeeeeeeeeeee
DisplayName                      : John Doe
UserPrincipalName                : example@contoso.onmicrosoft.com
Mail                             : example@contoso.onmicrosoft.com
UserType                         : Guest
AccountEnabled                   : True
LastSignInDateTime               : 03/02/2025 5:59:28 AM
LastSigninDaysAgo                : 30
lastSignInRequestId              : cccccccc-2222-3333-4444-dddddddddddd
lastNonInteractiveSignInDateTime : Unknown
LastNonInteractiveSigninDaysAgo  : Unknown
CreatedDateTime                  : 01/04/2025 5:55:34 AM
CreatedDaysAgo                   : 30
```

This command retrieves guest users without an interactive sign-in within the last 90 days.

## PARAMETERS

### -LastSignInBeforeDaysAgo

Specifies the number of days since the last interactive sign-in. Users who didn't sign in within this period are returned.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserType

Filters users based on their type (for example, "Member" or "Guest").

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "All"
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

You can pipe an integer value to the `-LastSignInBeforeDaysAgo` parameter.

## OUTPUTS

### System.Object

Returns a list of users who didn't sign in within the specified period.

## NOTES

## RELATED LINKS
