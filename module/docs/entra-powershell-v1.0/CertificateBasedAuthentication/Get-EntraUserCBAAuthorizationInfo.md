---
author: msewaweru
description: Retrieves authorization information for a Microsoft Entra ID user, including certificate-based authentication identifiers
external help file: Microsoft.Entra.CertificateBasedAuthentication-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 04/13/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserCBAAuthorizationInfo
schema: 2.0.0
title: Get-EntraUserCBAAuthorizationInfo
---

# Get-EntraUserCBAAuthorizationInfo

## SYNOPSIS

Retrieves authorization information for a Microsoft Entra ID user, including certificate-based authentication identifiers.

## SYNTAX

```powershell
Get-EntraUserCBAAuthorizationInfo
 [-UserId] <String>
 [-Raw]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserCBAAuthorizationInfo` cmdlet retrieves authorization information for a specified user in Microsoft Entra ID. This includes certificate user identifiers that are used for certificate-based authentication (CBA).

By default, the command returns a formatted object with parsed certificate details. You can use the `-Raw` parameter to get the unprocessed response from the Microsoft Graph API.

`Get-EntraUserAuthorizationInfo` is an alias of `Get-EntraUserCBAAuthorizationInfo`.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Privileged Authentication Administrator (for Cloud-only users)
- Hybrid Identity Administrator (for synchronized users)

## EXAMPLES

### Example 1: Get authorization information for a user by User Principal Name

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserCBAAuthorizationInfo -UserId 'SawyerM@contoso.com'
```

```Output
Id                : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName       : Sawyer Miller
UserPrincipalName : SawyerM@contoso.com
UserType          : Member
AuthorizationInfo : @{CertificateUserIds=System.Object[]; RawAuthorizationInfo=System.Collections.Hashtable}
```

This command retrieves the authorization information for the user with the specified User Principal Name.

### Example 2: Retrieve authorization information for a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
$userInfo = Get-EntraUserCBAAuthorizationInfo -UserId 'SawyerM@contoso.com'
$userInfo.AuthorizationInfo.CertificateUserIds | Format-Table Type, TypeName, Value
```

```Output
Type TypeName      Value
---- --------      -----
PN   PrincipalName sawyerm@marketing.contoso.com
S    Subject       CN=sawyerm@marketing.contoso.com
```

This example retrieves the authorization information.

### Example 3: Extract specific certificate user IDs

```powershell
Connect-Entra -Scopes 'User.Read.All'
$userInfo = Get-EntraUserCBAAuthorizationInfo -UserId 'SawyerM@contoso.com'
$userInfo.AuthorizationInfo.CertificateUserIds | Where-Object Type -eq "PN" | Select-Object -ExpandProperty Value
```

```Output
sawyerm@marketing.contoso.com
```

This example retrieves the authorization information and then filters to display only the Principal Name certificate values.

### Example 5: Retrieve raw API response

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserCBAAuthorizationInfo -UserId 'SawyerM@contoso.com' -Raw
```

```Output
Name                           Value
----                           -----
userType                       Member
authorizationInfo              {[certificateUserIds, System.Object[]]}
id                             aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
@odata.context                 https://graph.microsoft.com/..
displayName                    Sawyer Miller
userPrincipalName              sawyerm@contoso.com
```

This command retrieves the raw, unprocessed authorization information directly from the API.

### Example 6: Use the results with pipeline

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserCBAAuthorizationInfo -UserId 'SawyerM@contoso.com' |
    Select-Object UserPrincipalName, @{
        Name = 'CertificateTypes';
        Expression = { $_.AuthorizationInfo.CertificateUserIds.Type -join ", " }
    }
```

```Output
UserPrincipalName            CertificateTypes
-----------------            ----------------
sawyerm@marketing.contoso.com PN, S
```

This example retrieves the authorization information and creates a custom view showing the user principal name and certificate types.

## PARAMETERS

### -UserId

Specifies the identifier of the user. This can be either a User Principal Name (UPN, email address) or a GUID (user ID).

```yaml
Type: String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Raw

Indicates that the cmdlet returns the raw API response without processing. Use this parameter when you want to see the complete, unmodified response from Microsoft Graph.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: RawResponse

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a user ID or UPN to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSObject

By default, the cmdlet returns a custom PSObject with the following properties:

Id: The unique identifier of the user
DisplayName: The display name of the user
UserPrincipalName: The user principal name (email address) of the user
UserType: The type of user account (for example, "Member", "Guest")
AuthorizationInfo: An object containing:
CertificateUserIds: An array of parsed certificate user ID objects
RawAuthorizationInfo: The original authorization info from the API.

Note: When the `-Raw` parameter is used, the cmdlet returns the raw API response as a PSObject.

## NOTES

Certificate user IDs are returned in the X509 format. The common types are:

PN: Principal Name
S: Subject
I: Issuer
SR: Serial Number
SKI: Subject Key Identifier
SHA1-PUKEY: SHA1 Public Key

## RELATED LINKS

[Set-EntraUserCBACertificateUserId](Set-EntraUserCBACertificateUserId.md)
[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids)
