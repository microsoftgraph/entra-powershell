---
title: Set-EntraBetaUser.
description: This article provides details on the Set-EntraBetaUser command.

ms.service: entra
ms.topic: reference
ms.date: 06/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaUser

## SYNOPSIS

Updates a user.

## Syntax

```powershell
Set-EntraBetaUser 
 -ObjectId <String> 
 [-PostalCode <String>] 
 [-MailNickName <String>] 
 [-ShowInAddressList <Boolean>]
 [-Department <String>] 
 [-DisplayName <String>] 
 [-Mobile <String>] 
 [-JobTitle <String>]
 [-ConsentProvidedForMinor <String>] 
 [-OtherMails <System.Collections.Generic.List`1[System.String]>] 
 [-PasswordPolicies <String>]
 [-SignInNames <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]>]
 [-PreferredLanguage <String>] 
 [-ImmutableId <String>] 
 [-City <String>]
 [-AgeGroup <String>]
 [-ExtensionProperty <System.Collections.Generic.Dictionary`2[System.String,System.String]>]
 [-UsageLocation <String>] 
 [-State <String>] 
 [-AccountEnabled <Boolean>] 
 [-Country <String>]
 [-UserPrincipalName <String>] 
 [-GivenName <String>] 
 [-PasswordProfile <PasswordProfile>] 
 [-UserType <String>]
 [-StreetAddress <String>] 
 [-CompanyName <String>] 
 [-Surname <String>] 
 [-TelephoneNumber <String>] 
 [-CreationType <String>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaUser` cmdlet updates a user in Microsoft Entra ID. Specify the `ObjectId` parameter to update a user in Microsoft Entra ID.

## Examples

### Example 1: Update a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$user = Get-EntraBetaUser -ObjectId 'TestUser@example.com' 
$user.DisplayName = 'YetAnotherTestUser' 
Set-EntraUser -ObjectId 'TestUser@example.com' -Displayname $user.Displayname
```

This example updates the specified user's Display name parameter.

### Example 2: Set the specified user's AccountEnabled parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraBetaUser -ObjectId 'aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb' -AccountEnabled $true
```

This example updates the specified user's AccountEnabled parameter.

### Example 3: Set all but specified user's ConsentProvidedForMinor parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraBetaUser -Top 1  | Where-Object -FilterScript { $_.DisplayName -notmatch '(George|James|Education)' } | ForEach-Object  { Set-EntraBetaUser -ObjectId $($_.ObjectId) -AgeGroup 'minor' -ConsentProvidedForMinor 'granted' }
```

This example updates the specified user's as minors with parental consent.

### Example 4: Set the specified user's parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraBetaUser -ObjectId 'aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb' -City 'Add city name' -CompanyName 'Microsoft' -ConsentProvidedForMinor 'Granted' -Country 'Add country name' -Department 'Add department name' -GivenName 'Mircosoft' -ImmutableId '#1' -JobTitle 'Manager' -MailNickName 'Add mailnickname' -Mobile '9984534564' -OtherMails 'test12@M365x99297270.OnMicrosoft.com' -PasswordPolicies 'DisableStrongPassword' -State 'UP' -StreetAddress 'Add address' -UserType 'Member'
```

This example updates the specified user's parameter.

### Example 5: Set the specified user's PasswordProfile parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$a = @{
   Password= "*****"
   ForceChangePasswordNextLogin = $true
   EnforceChangePasswordPolicy = $false
   }
Set-EntraBetaUser -ObjectId 'aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb' -PasswordProfile $a
```

This example updates the specified user's PasswordProfile parameter.

## PARAMETERS

### -AccountEnabled

Indicates whether the account is enabled.

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
When creating a local account, the property is required and you must set it to "LocalAccount".
When creating a work or school account, don't specify the property or set it to null.

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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtensionProperty

Add data to custom user properties as the basic open extensions or the more versatile schema extensions. See [more about extensions][Learn more about extensions].

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

This property is used to associate an on-premises Active Directory user account to their Microsoft Entra ID user object. This property must be specified when creating a new user account in the Graph if you're using a federated domain for the user's userPrincipalName property. Important: The $ and _ characters can't be used to when specifying this property.

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

Specifies a nickname for the user's mail address.

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

### -ObjectId

Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

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

### -OtherMails

Specifies other email addresses for the user.

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

```yaml
Type: System.PasswordProfile
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

Set to True to show this user in the address list.

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

The list of sign in names for this user

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

### -UsageLocation

A two letter country or region code (ISO standard 3166). Required for users that assigned licenses due to legal requirement to check for availability of services in country and regions. Examples include: "US," "JP," and "GB." Not nullable.

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

Specifies the user's user principal name.

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

A string value that can be used to classify user types in your directory, such as "Member" and "Guest."

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

Used by enterprise applications to determine the legal age group of the user. This property is read-only and calculated based on ageGroup and consentProvidedForMinor properties. Allowed values: null, minor, notAdult, and adult. Refer to the [legal age group property definitions][Learn more about age group and minor consent definitions].

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

The company name, which the user is associated. This property can be useful for describing the company that an external user comes from. The maximum length of the company name is 64 characters.

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

Sets whether consent has to obtained for minors. Allowed values: null, granted, denied, and notRequired.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[New-EntraBetaUser](New-EntraBetaUser.md)

[Remove-EntraBetaUser](Remove-EntraBetaUser.md)