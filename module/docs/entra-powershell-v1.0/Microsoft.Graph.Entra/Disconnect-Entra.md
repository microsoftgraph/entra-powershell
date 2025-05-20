---
title: Disconnect-Entra
description: This article provides details on the Disconnect-Entra Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Disconnect-Entra

schema: 2.0.0
---

# Disconnect-Entra

## Synopsis

Disconnects the current session from a Microsoft Entra ID tenant.

## Syntax

```powershell
Disconnect-Entra
 [<CommonParameters>]
```

## Description

The Disconnect-Entra cmdlet disconnects the current session from a Microsoft Entra ID tenant.

## Examples

### Example 1: Disconnect your session from a tenant

```powershell
 Disconnect-Entra
```

```output
ClientId               : 00001111-aaaa-2222-bbbb-3333cccc4444
TenantId               : bbbbcccc-1111-dddd-2222-eeee3333ffff
Scopes                 : {Agreement.ReadWrite.All, CustomSecAttributeDefinition.ReadWrite.All, TeamMember.Read.All...}
AuthType               : AppOnly
TokenCredentialType    : ClientCertificate
CertificateThumbprint  : AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00
CertificateSubjectName :
Account                :
AppName                : MG_graph_auth
ContextScope           : Process
Certificate            :
PSHostVersion          : 5.1.22621.2506
ManagedIdentityId      :
ClientSecret           :
Environment            : Global
```

This command disconnects your session from a tenant.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Connect-Entra](Connect-Entra.md)
