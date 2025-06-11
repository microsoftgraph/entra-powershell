---
title: Update-EntraUserFromFederated
description: This article provides details on the Update-EntraUserFromFederated command.

ms.topic: reference
ms.date: 02/23/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Update-EntraUserFromFederated

schema: 2.0.0
---

# Update-EntraUserFromFederated

## Synopsis

Updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

## Syntax

### CloudOnlyPasswordScenarios (Default)

```powershell
Update-EntraUserFromFederated
 -UserPrincipalName <String>
 [<CommonParameters>]
```

### HybridPasswordScenarios

```powershell
Update-EntraUserFromFederated
 -UserPrincipalName <String>
 -NewPassword <SecureString>
 [<CommonParameters>]
```

## Description

The `Update-EntraUserFromFederated` cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type. A new password must be provided for the user.

This process updates the password in Microsoft Entra ID and, if password writeback is enabled, syncs it to on-premises Active Directory. The admin can set a new password or let the system generate one. The user must change it at next sign-in.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The least privileged roles for this operation are:

- Authentication Administrator
- Privileged Authentication Administrator

For delegated scenarios, the administrator needs at least the Authentication Administrator or Privileged Authentication Administrator Microsoft Entra role.

Admins with `User Administrator`, `Helpdesk Administrator`, or `Password Administrator` roles can reset passwords for nonadmin users.

The new password is required for hybrid password setups. If omitted for cloud-only passwords, a system-generated password is returned. It’s a Unicode string, validated against the tenant's banned password list, and must meet cloud and/or on-premises password policies.

## Examples

### Example 1: Update a user in a domain

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
Update-EntraUserFromFederated -UserPrincipalName 'pattifuller@contoso.com'
```

```Output
Name                           Value
----                           -----
newPassword                    HuHu8765
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.passwordResetResponse
```

This command updates a user in a domain. The system generates and returns a password.

- `-UserPrincipalName` parameter specifies the Microsoft Entra ID UserID for the user to convert.

### Example 2: Update user password in a domain

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
$newPassword = '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Update-EntraUserFromFederated -UserPrincipalName 'pattifuller@contoso.com' -NewPassword $securePassword
```

This command updates a user in a domain by supplying a password for hybrid scenarios.

- `-UserPrincipalName` parameter specifies the Microsoft Entra ID UserID for the user to convert.
- `-NewPassword` parameter specifies the new password of the user.

## Parameters

### -UserPrincipalName

The Microsoft Entra ID UserID for the user to convert.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: UserId, Identity, UPN, ObjectId

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword

The new password of the user.

For tenants using hybrid password scenarios, specifying a new password is required. If you omit the password for a cloud-only account, the system generates one automatically. This generated password is a Unicode string without other encoding. Before acceptance, the password is validated against the tenant's banned password list and must meet the tenant's cloud and/or on-premises password requirements.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

- For more information, see [resetPassword](https://learn.microsoft.com/graph/api/authenticationmethod-resetpassword).

## Related links
