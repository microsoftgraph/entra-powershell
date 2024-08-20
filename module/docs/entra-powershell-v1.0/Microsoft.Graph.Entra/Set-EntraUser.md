---
title: Set-EntraUser
description: This article provides details on the Set-EntraUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraUser

schema: 2.0.0
---

# Set-EntraUser

## Synopsis
Updates a user.

## Syntax

```powershell
Set-EntraUser 
 -ObjectId <String> 
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

## Description
The Set-EntraUser cmdlet updates a user in Microsoft Entra ID.

## Examples

### Example 1: Update a user

```powershell
PS C:\> $user = Get-EntraUser -ObjectId TestUser@example.com 
PS C:\> $user.DisplayName = 'YetAnotherTestUser' 
PS C:\> Set-EntraUser -ObjectId TestUser@example.com -Displayname $user.Displayname
```

This example updates the specified user's Display name property.

### Example 2: Set the specified user's AccountEnabled property

```powershell
PS C:\> Set-EntraUser -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -AccountEnabled $true
```

This example updates the specified user's AccountEnabled property.

### Example 3: Set all but specified users as minors with parental consent

```powershell
PS C:\>Get-EntraUser -All  | 
Where-Object -FilterScript { $_.DisplayName -notmatch '(George|James|Education)' } | 
ForEach-Object  { Set-EntraUser -ObjectId $($_.ObjectId) -AgeGroup 'minor' -ConsentProvidedForMinor 'granted' }
```
This example updates the specified user's property.

### Example 4: Set the specified user's property

```powershell
PS C:\>Set-EntraUser -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -City "Add city name" -CompanyName "Microsoft" -ConsentProvidedForMinor Granted -Country 'Add country name' -Department "Add department name" -GivenName "Mircosoft" -ImmutableId "#1" -JobTitle "Manager" -MailNickName "Add mailnickname" -Mobile "9984534564" -OtherMails "test12@M365x99297270.OnMicrosoft.com" -PasswordPolicies "DisableStrongPassword" -State "UP" -StreetAddress "Add address" -UserType "Member"
```
This example updates the specified user's City property.

### Example 5: Set the specified user's PasswordProfile property

```powershell
PS C:\> $a = @{
   Password= "*****"
   ForceChangePasswordNextLogin = $true
   EnforceChangePasswordPolicy = $false
   }
PS C:\> Set-EntraUser -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -PasswordProfile $a
```
This example updates the specified user's PasswordProfile property.

## Parameters

### -AccountEnabled
Indicates whether the account is enabled.

```yaml
Type: Boolean
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Country
Specifies the user's country/region.

```yaml
Type: String
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
When we create a local account, the property is required and you must set it to "LocalAccount."
When creating a work or school account, don't specify the property or set it to null.

```yaml
Type: String
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImmutableId
This property is used to associate an on-premises Active Directory user account to their Microsoft Entra ID user object. This property must be specified when creating a new user account in the Graph if you're using a federated domain for the user's userPrincipalName property. Important: The $ and _ characters can't be used when specifying this property.

```yaml
Type: String
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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
Type: String
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
Type: String
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
Type: String
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
Type: Boolean
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[New-EntraUser](New-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)

