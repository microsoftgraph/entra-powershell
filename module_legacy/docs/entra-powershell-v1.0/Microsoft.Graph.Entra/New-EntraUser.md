---
title: New-EntraUser
description: This article provides details on the New-EntraUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraUser

schema: 2.0.0
---

# New-EntraUser

## Synopsis

Creates a Microsoft Entra ID user.

## Syntax

```powershell
New-EntraUser
 -DisplayName <String>
 -AccountEnabled <Boolean>
 -PasswordProfile <PasswordProfile>
 [-City <String>]
 [-UserStateChangedOn <String>]
 [-CompanyName <String>]
 [-PreferredLanguage <String>]
 [-FacsimileTelephoneNumber <String>]
 [-GivenName <String>]
 [-Mobile <String>]
 [-UsageLocation <String>]
 [-PostalCode <String>]
 [-AgeGroup <String>]
 [-CreationType <String>]
 [-ExtensionProperty <System.Collections.Generic.Dictionary`2[System.String,System.String]>]
 [-ConsentProvidedForMinor <String>]
 [-MailNickName <String>]
 [-ImmutableId <String>]
 [-Country <String>]
 [-SignInNames <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]>]
 [-Department <String>]
 [-PasswordPolicies <String>]
 [-JobTitle <String>]
 [-IsCompromised <Boolean>]
 [-UserState <String>]
 [-UserType <String>]
 [-OtherMails <System.Collections.Generic.List`1[System.String]>]
 [-PhysicalDeliveryOfficeName <String>]
 [-UserPrincipalName <String>]
 [-State <String>]
 [-StreetAddress <String>]
 [-TelephoneNumber <String>]
 [-Surname <String>]
 [-ShowInAddressList <Boolean>]
 [<CommonParameters>]
```

## Description

The `New-EntraUser` cmdlet creates a user in Microsoft Entra ID. Specify the `DisplayName`,`AccountEnabled`, and `PasswordProfile` parameter to create a user.

## Examples

### Example 1: Create a user using MailNickName parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = '<Password>'
$userParams = @{
    DisplayName       = 'Avery Iona'
    PasswordProfile   = $PasswordProfile
    UserPrincipalName = 'AveryI@contoso.com'
    AccountEnabled    = $true
    MailNickName      = 'averyi'
}

New-EntraUser @userParams
```

```Output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Avery Iona    AveryI@contoso.com             Member
```

This command creates a new user.

### Example 2: Create a user using AgeGroup parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = '<Password>'

$userParams = @{
    DisplayName       = 'Peyton Davis'
    PasswordProfile   = $PasswordProfile
    UserPrincipalName = 'PeytonD@contoso.com'
    AccountEnabled    = $true
    MailNickName      = 'PeytonD'
    AgeGroup          = 'adult'
}

New-EntraUser @userParams
```

```Output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
bbbbbbbb-1111-2222-3333-cccccccccccc Peyton Davis    PeytonD@contoso.com             Member
```

This command creates a new user.

### Example 3: Create a user using City parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = '<Password>'

$userParams = @{
    DisplayName       = 'Blake Martin'
    PasswordProfile   = $PasswordProfile
    UserPrincipalName = 'BlakeM@contoso.com'
    AccountEnabled    = $true
    MailNickName      = 'BlakeM'
    City              = 'New York'
}

New-EntraUser @userParams
```

```Output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
cccccccc-2222-3333-4444-dddddddddddd Blake Martin    BlakeM@contoso.com             Member
```

This command creates a new user.

### Example 4: Create a user using Department parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = '<Password>'
$userParams = @{
    DisplayName       = 'Parker Jones'
    PasswordProfile   = $PasswordProfile
    UserPrincipalName = 'ParkerJ@contoso.com'
    AccountEnabled    = $true
    MailNickName      = 'ParkerJ'
    Department        = 'IT'
}

New-EntraUser @userParams
```

```Output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
dddddddd-3333-4444-5555-eeeeeeeeeeee Parker Jones    ParkerJ@contoso.com             Member
```

This command creates a new user.

### Example 5: Create a user using Mobile parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = '<Password>'

$UserParams = @{
    DisplayName        = 'Sawyer Miller'
    PasswordProfile    = $PasswordProfile
    UserPrincipalName  = 'SawyerM@contoso.com'
    AccountEnabled     = $true
    MailNickName       = 'SawyerM'
    Mobile             = '+18989898989'
}

New-EntraUser @UserParams
```

```Output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
eeeeeeee-4444-5555-6666-ffffffffffff Sawyer Miller    SawyerM@contoso.com             Member
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

### -ExtensionProperty

Add data to custom user properties as the basic **open extensions** or the more versatile **schema extensions**.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: (All)
Aliases:

Required: False
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

This property is used to associate an on-premises user account to their Microsoft Entra ID user object.
This property must be specified when creating a new user account in the Graph if you're using a federated domain for the user's userPrincipalName (UPN) property.

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

### -IsCompromised

Indicates whether this user is compromised.

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

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

Then you can proceed to set the value of the password in this variable:

$PasswordProfile.Password = "\<Password\>"

And finally you can pass this variable to the cmdlet:

New-EntraUser -PasswordProfile $PasswordProfile ...

Other attributes that can be set in the PasswordProfile are

- $PasswordProfile.EnforceChangePasswordPolicy - a boolean indicating that the change password policy is enababled or disabled for this user $PasswordProfile.

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

### -PhysicalDeliveryOfficeName

Specifies the user's physical delivery office name.

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

### -TelephoneNumber

Specifies a telephone number.

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

### -FacsimileTelephoneNumber

Specifies the user's telephone number.

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

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)

[Set-EntraUser](Set-EntraUser.md)
