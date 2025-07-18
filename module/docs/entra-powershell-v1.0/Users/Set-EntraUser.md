---
author: msewaweru
description: This article provides details on the Set-EntraUser command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 03/16/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUser
schema: 2.0.0
title: Set-EntraUser
---

# Set-EntraUser

## SYNOPSIS

Updates a user.

## SYNTAX

```powershell
Set-EntraUser
 -UserId <String>
 [-PostalCode <String>]
 [-CompanyName <String>]
 [-GivenName <String>]
 [-Mobile <String>]
 [-PreferredLanguage <String>]
 [-CreationType <String>]
 [-UsageLocation <String>]
 [-UserType <String>]
 [-AgeGroup <String>]
 [-MailNickName <String>]
 [-ExtensionProperty <System.Collections.Generic.Dictionary`2[System.String,System.String]>]
 [-ConsentProvidedForMinor <String>]
 [-ImmutableId <String>]
 [-Country <String>]
 [-SignInNames <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]>]
 [-Department <String>]
 [-StreetAddress <String>]
 [-PasswordPolicies <String>]
 [-JobTitle <String>]
 [-City <String>]
 [-OtherMails <System.Collections.Generic.List`1[System.String]>]
 [-UserPrincipalName <String>]
 [-DisplayName <String>]
 [-AccountEnabled <Boolean>]
 [-PasswordProfile <PasswordProfile>]
 [-State <String>]
 [-TelephoneNumber <String>]
 [-Surname <String>]
 [-ShowInAddressList <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraUser` cmdlet updates a user in Microsoft Entra ID. Specify the `UserId` parameter to update a user in Microsoft Entra ID.

`Update-EntraUser` is an alias for `Set-EntraUser`.

## EXAMPLES

### Example 1: Update a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -DisplayName 'Updated user Name'
```

This example updates the specified user's Display name parameter.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.

### Example 2: Set the specified user's AccountEnabled parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -AccountEnabled $true
```

This example updates the specified user's AccountEnabled parameter.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.
- `-AccountEnabled` Specifies whether the account is enabled.

### Example 3: Set all but specified users as minors with parental consent

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraUser -All | Where-Object -Property DisplayName -Match '(George|James|Education)' |
ForEach-Object { Set-EntraUser -UserId $($_.Id) -AgeGroup 'minor' -ConsentProvidedForMinor 'granted' }
```

This example updates the specified user's as minors with parental consent.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.
- `-ConsentProvidedForMinor` Sets whether consent has to obtained for minors. Allowed values: null, granted, denied, and notRequired.

### Example 4: Set the specified user's property

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$params = @{
    UserId           = 'SawyerM@contoso.com'
    City             = 'Add city name'
    CompanyName      = 'Microsoft'
    Country          = 'Add country name'
    Department       = 'Add department name'
    GivenName        = 'Sawyer Miller G'
    JobTitle         = 'Manager'
    MailNickName     = 'Add mailnickname'
    Mobile           = '9984534564'
    OtherMails       = 'johndoe@contosodev.com'
    PasswordPolicies = 'DisableStrongPassword'
    State            = 'UP'
    StreetAddress    = 'Add address'
    UserType         = 'Member'
}
Set-EntraUser @params
```

This example updates the specified user's property.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.
- `-UserType` classify user types in your directory, such as "Member" and "Guest."
- `-PasswordPolicies` Specifies password policies for the user.
- `-OtherMails` Specifies other email addresses for the user

### Example 5: Set the specified user's PasswordProfile parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -PasswordProfile @{
    Password = '*****'
    ForceChangePasswordNextSignIn = $true
}
```

This example updates the specified user's PasswordProfile parameter.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.
- `-PasswordProfile` specifies the user's password profile.

### Example 6: Set user's usage location for license assignment

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -UsageLocation 'US'
```

This example updates the specified user's Usage Location for license management.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.
- `-UsageLocation` specifies the user's usage location. Two-letter ISO 3166 country code. Required for licensed users to check service availability. Examples: US, JP, GB. Not nullable.

### Example 7: Update user's password policy

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraUser -UserId 'SawyerM@contoso.com' | Set-EntraUser -PasswordPolicies DisablePasswordExpiration
```

This example updates the specified user's password policy.

Possible values for password policy include:

- `DisableStrongPassword`: Allows weaker passwords than the default policy.
- `DisablePasswordExpiration`: Prevents passwords from expiring.

You can specify both values together, for example: `DisablePasswordExpiration` and `DisableStrongPassword`. For example, `Set-EntraUser -UserId 'SawyerM@contoso.com' -PasswordPolicies "DisablePasswordExpiration,DisableStrongPassword"`.

### Example 8: Set user's extension properties

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Helpdesk Application'"
$extensionName = (Get-EntraApplicationExtensionProperty -ApplicationId $application.Id).Name | Select-Object -First 1
$additionalProperties = @{ $extensionName = "Survey.Report" }
Set-EntraUser -UserId 'SawyerM@contoso.com' -AdditionalProperties $additionalProperties
```

This example updates the specified user's extension properties, for example, an app role for an application.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.

### Example 9: update user's onPremisesExtension attributes properties

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -AdditionalProperties @{
    onPremisesExtensionAttributes = @{
        extensionAttribute1 = "Job Group D"
        extensionAttribute2 = "Audit Role"
    }
}
```

This example updates the specified user's onPremisesExtensionAttributes properties.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.

### Example 10: update user's phone details

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUser -UserId 'SawyerM@contoso.com' -BusinessPhones '+1 425 555 0109' -OfficeLocation '18/2111'
```

This example updates the specified user's onPremisesExtensionAttributes properties.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.

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

Add data to custom user properties as the basic open extensions or the more versatile schema extensions.

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

This property links an on-premises Active Directory user account to its Microsoft Entra ID user object. You must specify this property when creating a new user account in Graph if the user's userPrincipalName uses a federated domain.

Important: Do not use the $ and \_ characters when specifying this property.

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

### -UserId

Specifies the ID of a user (as a User Principle Name or UserId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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
Type: PasswordProfile
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

Used by enterprise applications to determine the legal age group of the user. This property is read-only and calculated based on ageGroup and consentProvidedForMinor properties. Allowed values: null, minor, notAdult, and adult. See, [legal-age-group](https://learn.microsoft.com/graph/api/resources/user#legal-age-group-property-definitions).

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

`Update-EntraUser` is an alias for `Set-EntraUser`.

## RELATED LINKS

[Get-EntraUser](Get-EntraUser.md)

[New-EntraUser](New-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)
