---
title: Reset-EntraStrongAuthenticationMethodByUpn
description: This article provides details on the Reset-EntraStrongAuthenticationMethodByUpn command.


ms.topic: reference
ms.date: 03/20/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.SignIns-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Reset-EntraStrongAuthenticationMethodByUpn

schema: 2.0.0
---

# Reset-EntraStrongAuthenticationMethodByUpn

## Synopsis

Resets the strong authentication method using the User Principal Name (UPN).

## Syntax

```powershell
Reset-EntraStrongAuthenticationMethodByUpn
 -UserPrincipalName <String>
 [-TenantId <String>]
 [<CommonParameters>]
```

## Description

The `Reset-EntraStrongAuthenticationMethodByUpn` cmdlet resets the strong authentication method by using the User Principal Name (UPN). It is recommended to use Temporary Access Pass (TAP) to allow a users to sign in temporarily without MFA instead of deleting all methods.

Deleting all methods will force the user to re-register MFA next time they sign in.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged roles for this operation are:

- Authentication Administrator  
- Privileged Authentication Administrator

## Examples

### Example 1: Resets the strong authentication method by using the User Principal Name

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName 'SawyerM@contoso.com'
```

This example demonstrates how to reset the strong authentication method by using the User Principal Name (UPN).

- `-UserPrincipalName` parameter specifies the User Principal Name (UPN) of the user whose strong authentication method is being reset. You can use `-UserId`, `-Identity`, `-UPN`, `-ObjectId` as an alias for `-UserPrincipalName`.

## Parameters

### -UserPrincipalName

Specifies the User Principal Name (UPN) of the user whose strong authentication method is being reset.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: UserId, Identity, UPN, ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId

The unique ID of the tenant to perform the operation on. The TenantID applies to the logged-in Tenant ID. Ensures backward compatibility with Azure AD and MSOnline for partner scenarios.

```yaml
Type: System.String
Parameter Sets: 
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links
