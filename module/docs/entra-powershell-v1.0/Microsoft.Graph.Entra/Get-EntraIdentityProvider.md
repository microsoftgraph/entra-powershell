---
title: Get-EntraIdentityProvider
description: This article provides details on the Get-EntraIdentityProvider command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraIdentityProvider

## Synopsis

This cmdlet is used to retrieve the configured identity providers in the directory.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraIdentityProvider 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraIdentityProvider 
 -Id <String> 
 [<CommonParameters>]
```

## Description

This cmdlet is used to retrieve the identity providers that are configured in the directory.
These identity providers can be used to allow users to sign up for or sign into applications secured by Microsoft Entra ID B2C.

Configuring an identity provider in your Microsoft Entra ID tenant also enables future B2B guest scenarios.
For example, for an organization that has resources in Office 365 that need to be shared with a Gmail user, the Gmail user can use their Google account credentials to authenticate and access the documents.

The current set of identity providers can be Microsoft, Google, Facebook, Amazon, or LinkedIn.

## Examples

### Example 1: Retrieve all identity providers

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All'
Get-EntraIdentityProvider
```

```output
Id                   DisplayName
--                   -----------
AADSignup-OAUTH      Azure Active Directory Sign up
Google-OAUTH         Test
EmailOtpSignup-OAUTH Email One Time Passcode
MSASignup-OAUTH      Microsoft Account
```

This example retrieves the list of all configured identity providers and their properties.

### Example 2: Retrieve identity provider by Id

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All'
Get-EntraIdentityProvider -Id Google-OAUTH
```

```output
Id           DisplayName
--           -----------
Google-OAUTH Test
```

This example retrieves the properties for the specified identity provider.

## Parameters

### -Id

The unique identifier for an identity provider.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links
