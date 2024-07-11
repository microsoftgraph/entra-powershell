---
title: Get-EntraCurrentSessionInfo
description: This article provides details on the Get-EntraCurrentSessionInfo command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraCurrentSessionInfo

## Synopsis

This cmdlet returns the current session state.

## Syntax

```powershell
Get-EntraCurrentSessionInfo 
 [<CommonParameters>]
```

## Description

The `Get-EntraCurrentSessionInfo` cmdlet returns the current session state.

## Examples

### Example 1: Get current session info

```powershell
Get-EntraCurrentSessionInfo
```

```output
ObjectId               :
ClientId               : 00001111-aaaa-2222-bbbb-3333cccc4444
TenantId               : bbbbcccc-1111-dddd-2222-eeee3333ffff
Scopes                 : {User.Read.All, Policy.Read.IdentityProtection, Group.Read.All...}
AuthType               : AppOnly
TokenCredentialType    : ClientCertificate
CertificateThumbprint  : AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00
CertificateSubjectName :
Account                :
AppName                : My Entra App
ContextScope           : Process
Certificate            :
PSHostVersion          : 5.1.22621.2506
ManagedIdentityId      :
ClientSecret           :
Environment            : Global
```

This command gets the current session info.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraContext](Get-EntraContext.md)
