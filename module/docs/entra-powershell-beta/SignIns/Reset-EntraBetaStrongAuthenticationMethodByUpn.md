---
title: Reset-EntraBetaStrongAuthenticationMethodByUpn
description: This article provides details on the Reset-EntraBetaStrongAuthenticationMethodByUpn command.


ms.topic: reference
ms.date: 03/20/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Reset-EntraBetaStrongAuthenticationMethodByUpn

schema: 2.0.0
---

# Reset-EntraBetaStrongAuthenticationMethodByUpn

## Synopsis

Resets the strong authentication method using the User Principal Name (UPN).

## Syntax

```powershell
Reset-EntraBetaStrongAuthenticationMethodByUpn
 -UserPrincipalName <String>
 [<CommonParameters>]
```

## Description

The `Reset-EntraBetaStrongAuthenticationMethodByUpn` cmdlet resets the strong authentication method by using the User Principal Name (UPN).

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged roles for this operation are:

- Authentication Administrator  
- Privileged Authentication Administrator

## Examples

### Example 1: Resets the strong authentication method by using the User Principal Name

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite.All'
Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName 'SawyerM@contoso.com'
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
