---
title: Update-EntraBetaUserFromFederated
description: This article provides details on the Update-EntraBetaUserFromFederated command.

ms.topic: reference
ms.date: 08/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Update-EntraBetaUserFromFederated

schema: 2.0.0
---

# Update-EntraBetaUserFromFederated

## Synopsis

Updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

## Syntax

```powershell
Update-EntraBetaUserFromFederated
 -UserPrincipalName <String>
 [-NewPassword <String>]
 [<CommonParameters>]
```

## Description

The `Update-EntraBetaUserFromFederated` cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type. A new password must be provided for the user.

This process writes the new password to Microsoft Entra ID and, if configured with password writeback, pushes it to on-premises Active Directory. The admin can provide a new password or let the system generate one. The user will be prompted to change their password at their next sign-in.

For delegated scenarios, the administrator needs at least the Authentication Administrator or Privileged Authentication Administrator Microsoft Entra role.

Admins with User Administrator, Helpdesk Administrator, or Password Administrator roles can also reset passwords for non-admin users and a limited set of admin roles.

## Examples

### Example 1: Update a user in a domain

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
Update-EntraBetaUserFromFederated -UserPrincipalName 'pattifuller@contoso.com'
```

This command updates a user in a domain.

- `-UserPrincipalName` parameter specifies the Microsoft Entra ID UserID for the user to convert.

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

For tenants using hybrid password scenarios, specifying a new password is required. If you omit the password for a cloud-only account, the system generates one automatically. This generated password is a Unicode string without additional encoding. Before acceptance, the password is validated against the tenant's banned password list and must meet the tenant's cloud and/or on-premises password requirements.

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
