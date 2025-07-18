---
title: Reset-EntraStrongAuthenticationMethodByUpn
description: This article provides details on the Reset-EntraStrongAuthenticationMethodByUpn command.


ms.topic: reference
ms.date: 08/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Reset-EntraStrongAuthenticationMethodByUpn

schema: 2.0.0
---

# Reset-EntraStrongAuthenticationMethodByUpn

## Synopsis

Resets the strong authentication method using the User Principal Name (UPN).

## Syntax

```powershell
Reset-EntraStrongAuthenticationMethodByUpn
 -UserPrincipalName <String>
 [<CommonParameters>]
```

## Description

The `Reset-EntraStrongAuthenticationMethodByUpn` cmdlet resets the strong authentication method by using the User Principal Name (UPN).

## Examples

### Example 1: Resets the strong authentication method by using the User Principal Name

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite', 'UserAuthenticationMethod.ReadWrite.All'
Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName 'SawyerM@contoso.com'
```

This example demonstrates how to reset the strong authentication method by using the User Principal Name (UPN).

- `-UserPrincipalName` parameter specifies the User Principal Name (UPN) of the user whose strong authentication method is being reset.

## Parameters

### -UserPrincipalName

Specifies the User Principal Name (UPN) of the user whose strong authentication method is being reset.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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
