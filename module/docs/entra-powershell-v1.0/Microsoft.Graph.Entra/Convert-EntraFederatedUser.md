---
title: Convert-EntraFederatedUser
description: This article provides details on the Convert-EntraFederatedUser command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Convert-EntraFederatedUser

## Synopsis

Updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

## Syntax

```powershell
Convert-EntraFederatedUser
 -UserPrincipalName <String>
 [-NewPassword <String>]
 [<CommonParameters>]
```

## Description

The `Convert-EntraFederatedUser` cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type. A new password must be provided for the user.

This process writes the new password to Microsoft Entra ID and, if configured with password writeback, pushes it to on-premises Active Directory. The admin can provide a new password or let the system generate one. The user will be prompted to change their password at their next sign-in.

For delegated scenarios, the administrator needs at least the Authentication Administrator or Privileged Authentication Administrator Microsoft Entra role.

Admins with User Administrator, Helpdesk Administrator, or Password Administrator roles can also reset passwords for non-admin users and a limited set of admin roles.

## Examples

### EXAMPLE 1: Update a user in a domain

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
Convert-EntraFederatedUser -UserPrincipalName 'pattifuller@contoso.com'
```

This command updates a user in a domain.

## Parameters

### -UserPrincipalName

The Microsoft Entra ID UserID for the user to convert.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword

The new password of the user.

The new password is required for tenants with hybrid password scenarios. If omitted for a cloud-only password, the system generates a password. This password is a Unicode string with no other encoding. It is validated against the tenant's banned password system before acceptance and must meet the tenant's cloud and/or on-premises password requirements.

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

- For more information, see [resetPassword](/graph/api/authenticationmethod-resetpassword).

## Related Links
