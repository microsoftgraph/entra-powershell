---
title: Get-EntraBetaUserAuthenticationRequirement
description: This article provides details on the  Get-EntraBetaUserAuthenticationRequirement Command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserAuthenticationRequirement

schema: 2.0.0
---

# Get-EntraBetaUserAuthenticationRequirement

## Synopsis

Retrieve the authentication method status of a user.

## Syntax

```powershell
Get-EntraBetaUserAuthenticationRequirement
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserAuthenticationRequirement` cmdlet retrieves the authentication method status of a user.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles can perform this operation:

- Global Reader  
- Authentication Policy Administrator

## Examples

### Example 1: Retrieve a User's MFA Status

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaUserAuthenticationRequirement -UserId 'SawyerM@contoso.com'
```

```Output
perUserMfaState @odata.context
--------------- --------------
disabled        https://graph.microsoft.com/beta/$metadata#users(..)
```

This example retrieves the authentication method status of a user.

A user's state shows whether an Authentication Administrator enrolls them in per-user Microsoft Entra multifactor authentication. User accounts have one of three distinct states in Microsoft Entra MFA:

- `Disabled` - The default state for a user not enrolled in per-user Microsoft Entra multifactor authentication.
- `Enabled` - The user is enrolled in per-user Microsoft Entra multifactor authentication, but can still use their password for  legacy authentication. If the user has no registered MFA authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser).
- `Enforced` - The user is enrolled per-user in Microsoft Entra multifactor authentication. If the user has no registered authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser). Users who complete registration while they're Enabled are automatically moved to the Enforced state.

## Parameters

### -UserId

Specifies the ID (as a UserPrincipalName or UserId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

The most effective way to protect users with Microsoft Entra MFA is by creating a Conditional Access policy. Conditional Access, a feature available in Microsoft Entra ID P1 and P2, allows you to enforce MFA based on specific conditions and scenarios. To learn how to set up Conditional Access, refer to the tutorial: [Secure user sign-in events with Microsoft Entra multifactor authentication](https://learn.microsoft.com/entra/identity/authentication/tutorial-enable-azure-mfa).

For Microsoft Entra ID Free tenants without Conditional Access, you can [use security defaults](https://learn.microsoft.com/entra/fundamentals/security-defaults) to protect users. MFA prompts are automatic, but you can't customize the rules.

## Related Links
