---
title: New-EntraBetaUser
description: This article provides details on the New-EntraBetaUser command.

ms.topic: reference
ms.date: 06/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Users-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaUser

schema: 2.0.0
---

# New-EntraBetaUser

## Synopsis

Creates a Microsoft Entra ID user.

## Syntax

```powershell
New-EntraBetaUser
 -DisplayName <String>
 -AccountEnabled <Boolean>
 -PasswordProfile <PasswordProfile>
 [-PostalCode <String>]
 [-MailNickName <String>]
 [-ShowInAddressList <Boolean>]
 [-Department <String>]
 [-BusinessPhones <String>]
 [-PreferredLanguage <String>]
 [-Mobile <String>]
 [-JobTitle <String>]
 [-ConsentProvidedForMinor <String>]
 [-PasswordPolicies <String>]
 [-SignInNames <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]>]
 [-OtherMails <System.Collections.Generic.List`1[System.String]>]
 [-UserState <String>]
 [-ImmutableId <String>]
 [-City <String>]
 [-AgeGroup <String>]
 [-UsageLocation <String>]
 [-UserStateChangedOn <String>]
 [-Country <String>]
 [-UserPrincipalName <String>]
 [-GivenName <String>]
 [-UserType <String>]
 [-StreetAddress <String>]
 [-State <String>]
 [-CompanyName <String>]
 [-FaxNumber <String>]
 [-Surname <String>]
 [-CreationType <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaUser` cmdlet creates a user in Microsoft Entra ID. Specify the `DisplayName`,`AccountEnabled`, and `PasswordProfile` parameter to create a user.

## Examples

### Example 1: Create a user using MailNickName parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = '<Password>'
$params = @{
    DisplayName = 'New User'
    PasswordProfile = $passwordProfile
    UserPrincipalName = 'NewUser@contoso.com'
    AccountEnabled = $true
    MailNickName = 'Newuser'
}

New-EntraBetaUser @params
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
New User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee      NewUser@contoso.com
```

This command creates a new user.

### Example 2: Create a user using AgeGroup parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = '<Password>'
$params = @{
    DisplayName = 'New User'
    PasswordProfile = $passwordProfile
    UserPrincipalName = 'NewUser@contoso.com'
    AccountEnabled = $true
    MailNickName = 'Newuser'
    AgeGroup = 'adult'
}

New-EntraBetaUser @params
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
New User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee      NewUser@contoso.com
```

This command creates a new user.

### Example 3: Create a user using City parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = '<Password>'
$params = @{
    DisplayName = 'New User'
    PasswordProfile = $passwordProfile
    UserPrincipalName = 'NewUser@contoso.com'
    AccountEnabled = $true
    MailNickName = 'Newuser'
    City = 'New York'
}

New-EntraBetaUser @params
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
New User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee      NewUser@contoso.com
```

This command creates a new user.

### Example 4: Create a user using Department parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = '<Password>'
$params = @{
    DisplayName = 'New User'
    PasswordProfile = $passwordProfile
    UserPrincipalName = 'NewUser@contoso.com'
    AccountEnabled = $true
    MailNickName = 'Newuser'
    Department = 'IT'
}

New-EntraBetaUser @params
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
New User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee      NewUser@contoso.com
```

This command creates a new user.

### Example 5: Create a user using Mobile parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = '<Password>'
$params = @{
    DisplayName = 'New User'
    PasswordProfile = $passwordProfile
    UserPrincipalName = 'NewUser@contoso.com'
    AccountEnabled = $true
    MailNickName = 'Newuser'
    Mobile = '02883655253'
}

New-EntraBetaUser @params
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
New User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee      NewUser@contoso.com
```

This command creates a new user.

## Parameters

### -AccountEnabled

Indicates whether the user's account is enabled.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -City

Specifies the user's city.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Country

Specifies the user's country.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreationType

Indicates whether the user account is a local account for a Microsoft Entra ID B2C tenant.
Possible values are "LocalAccount" and null.

- When user creating a local account, the property is required and you must set it to "LocalAccount".
- When user creating a work or school account, don't specify the property or set it to null.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Department

Specifies the user's department.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the user's display name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GivenName

Specifies the user's given name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImmutableId

This property links an on-premises user account to its Microsoft Entra ID object and is required when creating a new user in Microsoft Graph if the user's userPrincipalName (UPN) is in a federated domain.

Important: The $ and _ characters can't be used when specifying this property.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobTitle

Specifies the user's job title.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailNickName

Specifies the user's mail nickname.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mobile

Specifies the user's mobile phone number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OtherMails

A list of other email addresses for the user; for example: "<bob@contoso.com>", "<Robert@fabrikam.com>".

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordPolicies

Specifies password policies for the user.
This value is an enumeration with one possible value being "DisableStrongPassword", which allows weaker passwords than the default policy to be specified.
"DisablePasswordExpiration" can also be specified.
The two might be specified together; for example: "DisablePasswordExpiration, DisableStrongPassword".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordProfile

Specifies the user's password profile.

The parameter type for this parameter is "PasswordProfile".

In order to pass a parameter of this type, you first need to create a variable in PowerShell with that type:

$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

Then you can proceed to set the value of the password in this variable:

$passwordProfile.Password = "\<Password\>"

And finally you can pass this variable to the cmdlet:

New-EntraBetaUser -PasswordProfile $passwordProfile ...

Other attributes that can be set in the PasswordProfile are

- $passwordProfile.EnforceChangePasswordPolicy - a boolean indicating that the change password policy is `enabled` or `disabled` for this user $passwordProfile.

- ForceChangePasswordNextLogin - a boolean indicating that the user must change the password at the next sign in.

```yaml
Type: PasswordProfile
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PostalCode

Specifies the user's postal code.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreferredLanguage

Specifies the user's preferred language.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowInAddressList

If True, show this user in the address list.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SignInNames

Specifies the collection of sign-in names for a local account in a Microsoft Entra ID B2C tenant.

Each sign-in name must be unique across the company/tenant.

The property must be specified when you create a local account user; don't specify it when you create a work or school account.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State

Specifies the user's state.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StreetAddress

Specifies the user's street address.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Surname

Specifies the user's surname.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BusinessPhones

Specifies a telephone number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: TelephoneNumber

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsageLocation

A two letter country code (ISO standard 3166).

Required for users that are assigned licenses due to legal requirement to check for availability of services in countries.

Examples include: "US", "JP", and "GB".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserPrincipalName

The user principal name (UPN) of the user.

The UPN is an Internet-style sign-in name for the user based on the Internet standard RFC 822.

By convention, this UPN should map to the user's email name.

The general format is "alias@domain".

For work or school accounts, the domain must be present in the tenant's collection of verified domains.

This property is required when a work or school account is created; it's optional for local accounts.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserType

A string value that can be used to classify user types in your directory, such as "Member" and "Guest".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FaxNumber

Specifies the user's fax number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: FacsimileTelephoneNumber, Fax

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgeGroup

Specifies the user's age group.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyName

Specifies the user's company name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConsentProvidedForMinor

Sets whether consent was obtained for minors.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserState

For an external user invited to the tenant using the invitation API, this property represents the invited user's
invitation status.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserStateChangedOn

Shows the timestamp for the latest change to the userState property.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaUser](Remove-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)
