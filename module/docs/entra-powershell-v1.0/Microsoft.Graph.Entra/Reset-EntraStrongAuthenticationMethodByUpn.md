---
title: Reset-EntraStrongAuthenticationMethodByUpn
description: This article provides details on the Reset-EntraStrongAuthenticationMethodByUpn command.


ms.topic: reference
ms.date: 08/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Reset-EntraStrongAuthenticationMethodByUpn

schema: 2.0.0
---

# Reset-EntraStrongAuthenticationMethodByUpn

## Synopsis

Resets the strong authentication method by using a user principal name.

## Syntax

```powershell
Reset-EntraStrongAuthenticationMethodByUpn 
 -UserPrincipalName <String> 
 [<CommonParameters>]
```

## Description

The `Reset-EntraStrongAuthenticationMethodByUpn` cmdlet resets the strong authentication method by using a user principal name.

## Examples

### Example 1: Resets the strong authentication method by using a user principal name

```powershell
Connect-Entra -Scopes 'UserAuthenticationMethod.ReadWrite', 'UserAuthenticationMethod.ReadWrite.All'

Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso.com#EXT#@M365x99297270.onmicrosoft.com'
```

This example demonstrates how to reset the strong authentication method by using a user principal name.

- `-UserPrincipalName` Specifies the user principal name for which to reset the strong authentication method.

## Parameters

### -UserPrincipalName

Specifies the user principal name for which to reset the strong authentication method.

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
