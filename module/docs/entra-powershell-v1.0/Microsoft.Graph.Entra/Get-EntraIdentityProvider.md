---
title: Get-EntraIdentityProvider
description: This article provides details on the Get-EntraIdentityProvider command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraIdentityProvider

schema: 2.0.0
---

# Get-EntraIdentityProvider

## Synopsis

This cmdlet is used to retrieve the configured identity providers in the directory.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraIdentityProvider
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraIdentityProvider
 -IdentityProviderBaseId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraIdentityProvider` cmdlet is used to retrieve the identity providers that have been configured in the directory.
These identity providers can be used to allow users to sign up for or sign into applications secured by Microsoft Entra ID B2C.

Configuring an identity provider in your Microsoft Entra ID tenant also enables future B2B guest scenarios.
For example, an organization has resources in Office 365 that needs to be shared with a Gmail user.
The Gmail user will use their Google account credentials to authenticate and access the documents.

The current set of identity providers can be Microsoft, Google, Facebook, Amazon, or LinkedIn.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- External Identity Provider Administrator

## Examples

### Example 1: Retrieve all identity providers

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All'
Get-EntraIdentityProvider
```

```Output
Id                   DisplayName
--                   -----------
AADSignup-OAUTH      Directory Sign up
Google-OAUTH         Test
EmailOtpSignup-OAUTH Email One Time Passcode
MSASignup-OAUTH      Microsoft Account
```

This example retrieves the list of all configured identity providers and their properties.

### Example 2: Retrieve identity provider by Id

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All'
Get-EntraIdentityProvider -IdentityProviderBaseId Google-OAUTH
```

```Output
Id           DisplayName
--           -----------
Google-OAUTH GoogleName
```

This example retrieves the properties for the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.

## Parameters

### -IdentityProviderBaseId

The unique identifier for an identity provider.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links
