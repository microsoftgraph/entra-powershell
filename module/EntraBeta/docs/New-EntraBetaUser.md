---
title: New-EntraBetaUser
description: This article provides details on the New-EntraBetaUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaUser

## SYNOPSIS
Creates a Microsoft Entra ID user.

## SYNTAX

```powershell
New-EntraBetaUser 
    -DisplayName <String> 
    -AccountEnabled <Boolean>
    -PasswordProfile <PasswordProfile>
    [-PostalCode <String>] 
    [-MailNickName <String>] 
    [-ShowInAddressList <Boolean>]
    [-Department <String>] 
    [-TelephoneNumber <String>] 
    [-PreferredLanguage <String>]
    [-Mobile <String>] 
    [-JobTitle <String>] 
    [-ConsentProvidedForMinor <String>]
    [-PhysicalDeliveryOfficeName <String>] 
    [-PasswordPolicies <String>] 
    [-IsCompromised <Boolean>]
    [-SignInNames <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]>]
    [-OtherMails <System.Collections.Generic.List`1[System.String]>] 
    [-UserState <String>] 
    [-ImmutableId <String>]
    [-City <String>] 
    [-AgeGroup <String>]
    [-ExtensionProperty <System.Collections.Generic.Dictionary`2[System.String,System.String]>]
    [-UsageLocation <String>] 
    [-UserStateChangedOn <String>] 
    [-Country <String>]
    [-UserPrincipalName <String>] 
    [-GivenName <String>] 
    [-UserType <String>] 
    [-StreetAddress <String>]
    [-State <String>] 
    [-CompanyName <String>]
    [-FacsimileTelephoneNumber <String>] 
    [-Surname <String>] 
    [-CreationType <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **New-EntraBetaUser** cmdlet creates a user in Microsoft Entra ID.

## EXAMPLES

### Example 1
```powershell
PS C:\> $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
PS C:\> $PasswordProfile.Password = "<Password>"
PS C:\> New-EntraBetaUser -DisplayName "New User" -PasswordProfile $PasswordProfile -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser"
```

```output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.com             Member
```

This command creates a new user.

### Example 2
```powershell
PS C:\> $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
PS C:\> $PasswordProfile.Password = "<Password>"
PS C:\> New-EntraBetaUser -DisplayName "New User" -PasswordProfile $PasswordProfile -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser" -AgeGroup "adult"
```

```output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.com             Member
```

This command creates a new user.

### Example 3
```powershell
PS C:\> $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
PS C:\> $PasswordProfile.Password = "<Password>"
PS C:\> New-EntraBetaUser -DisplayName "New User" -PasswordProfile $PasswordProfile -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser" -City "New York"
```

```output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.com             Member
```

This command creates a new user.

### Example 4
```powershell
PS C:\> $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
PS C:\> $PasswordProfile.Password = "<Password>"
PS C:\> New-EntraBetaUser -DisplayName "New User" -PasswordProfile $PasswordProfile -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser" -Department "IT"
```

```output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.com             Member
```

This command creates a new user.

### Example 5
```powershell
PS C:\> $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
PS C:\> $PasswordProfile.Password = "<Password>"
PS C:\> New-EntraBetaUser -DisplayName "New User" -PasswordProfile $PasswordProfile -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser" -Mobile "02883655253"
```

```output
ObjectId                             DisplayName UserPrincipalName               UserType
--------                             ----------- -----------------               --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.com             Member
```

This command creates a new user.

## PARAMETERS

### -AccountEnabled
Indicates whether the user's account is enabled.

```yaml
Type: Boolean
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
Specifies the user's country.

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
Indicates whether the user account is a local account for an Microsoft Entra ID B2C tenant.
Possible values are "LocalAccount" and null.
When creating a local account, the property is required and you must set it to "LocalAccount".
When creating a work or school account, do not specify the property or set it to null.

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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtensionProperty
@{Text=}

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
This property is used to associate an on-premises user account to their Microsoft Entra ID user object.
This property must be specified when creating a new user account in the Graph if you are using a federated domain for the user's userPrincipalName (UPN) property.

Important: The $ and _ characters cannot be used when specifying this property.

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

### -IsCompromised
Indicates whether this user is compromised.

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
Specifies the user's mail nickname.

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

### -OtherMails
A list of additional email addresses for the user; for example: "bob@contoso.com", "Robert@fabrikam.com".

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
The two may be specified together; for example: "DisablePasswordExpiration, DisableStrongPassword".

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
Note that the parameter type for this parameter is "PasswordProfile".
in order to pass a parameter of this type, you first need to create a vairable in PowerShell with that type:

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

Then you can proceed to set the value of the password in this variable:

$PasswordProfile.Password = "\<Password\>"

And finally you can pass this variable to the cmdlet:

New-EntraBetaUser -PasswordProfile $PasswordProfile ...

Other attributes that can be set in the PasswordProfile are

$PasswordProfile.EnforceChangePasswordPolicy - a boolean indicating that the change password policy is enababled or disabled for this user $PasswordProfile.ForceChangePasswordNextLogin - a boolean indicating that the user must change the password at the next sign in

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
Type: String
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
If True, show this user in the address list.

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
Specifies the collection of sign-in names for a local account in an Microsoft Entra ID B2C tenant.
Each sign-in name must be unique across the company/tenant.
The property must be specified when you create a local account user; do not specify it when you create a work or school account.

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
Specifies a telephone number.

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
A two letter country code (ISO standard 3166).
Required for users that will be assigned licenses due to legal requirement to check for availability of services in countries.
Examples include: "US", "JP", and "GB".

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
The user principal name (UPN) of the user.
The UPN is an Internet-style login name for the user based on the Internet standard RFC 822.
By convention, this should map to the user's email name.
The general format is "alias@domain".
For work or school accounts, the domain must be present in the tenant's collection of verified domains.
This property is required when a work or school account is created; it is optional for local accounts.

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
A string value that can be used to classify user types in your directory, such as "Member" and "Guest".

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

### -FacsimileTelephoneNumber
This specifies the user's telephone number.

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
This specifies the user's age group.

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
This specifies the user's company name.

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
Sets whether consent was obtained for minors.

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

### -UserState
For an external user invited to the tenant using the invitation API, this property represents the invited user's 
invitation status. 

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

### -UserStateChangedOn
Shows the timestamp for the latest change to the userState property.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaUser](Remove-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)

