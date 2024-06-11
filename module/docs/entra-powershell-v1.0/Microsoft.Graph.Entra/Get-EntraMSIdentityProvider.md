---
title: Get-EntraMSIdentityProvider
description: This article provides details on the Get-EntraMSIdentityProvider command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSIdentityProvider

## SYNOPSIS

This cmdlet is used to retrieve the configured identity providers in the directory.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraMSIdentityProvider 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSIdentityProvider 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet is used to retrieve the identity providers that are configured in the directory.
These identity providers can be used to allow users to sign up for or sign into applications secured by Microsoft Entra ID B2C.

Configuring an identity provider in your Microsoft Entra ID tenant also enables future B2B guest scenarios.
For example, for an organization that has resources in Office 365 that need to be shared with a Gmail user, the Gmail user can use their Google account credentials to authenticate and access the documents.

The current set of identity providers can be Microsoft, Google, Facebook, Amazon, or LinkedIn.

## EXAMPLES

### Example 1: Retrieve all identity providers

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All'
Get-EntraMSIdentityProvider
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
Get-EntraMSIdentityProvider -Id Google-OAUTH
```

```output
Id           DisplayName
--           -----------
Google-OAUTH Test
```

This example retrieves the properties for the specified identity provider.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
