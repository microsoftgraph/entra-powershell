---
author: msewaweru
description: This article provides details on the Get-EntraUserAuthenticationMethod command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.SignIns
ms.author: eunicewaweru
ms.date: 11/11/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.SignIns/Get-EntraUserAuthenticationMethod
schema: 2.0.0
title: Get-EntraUserAuthenticationMethod
---

# Get-EntraUserAuthenticationMethod

## SYNOPSIS

Retrieve a list of a user's registered authentication methods.

## SYNTAX

```powershell
Get-EntraUserAuthenticationMethod
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserAuthenticationMethod` cmdlet retrieves a list of a user's registered authentication methods. An authentication method is a way for a user to verify their identity, such as a password, phone (SMS or voice), or FIDO2 security key.

In delegated scenarios involving work or school accounts, where the signed-in user is acting on behalf of another user, the signed-in user must be assigned either a supported Microsoft Entra role or a custom role with the necessary permissions. For this operation, the following least privileged roles are supported:

- Global Reader  
- Authentication Administrator  
- Privileged Authentication Administrator

## EXAMPLES

### Example 1: Get a list of authentication methods registered to a user

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.Read.All'
Get-EntraUserAuthenticationMethod -UserId 'SawyerM@Contoso.com' | Select-Object Id, DisplayName, AuthenticationMethodType
```

```Output
Id                                   DisplayName   AuthenticationMethodType  
--                                   -----------   ------------------------  
00001111-aaaa-2222-bbbb-3333cccc4444               #microsoft.graph.passwordAuthenticationMethod  
11112222-bbbb-3333-cccc-4444dddd5555 iPhone 16     #microsoft.graph.microsoftAuthenticatorAuthenticationMethod
```

This example retrieves a Get a list of a user's registered authentication methods.

- `-UserId` parameter specifies the object ID of a user(as a UserPrincipalName or ObjectId).

## PARAMETERS

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

The authentication administrator only sees masked phone numbers.

## RELATED LINKS
