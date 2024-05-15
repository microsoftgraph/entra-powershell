---
title: Disconnect-Entra.
description: This article provides details on the Disconnect-Entra Command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 04/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Disconnect-Entra

## SYNOPSIS
Disconnects the current session from a Microsoft Entra ID tenant.

## SYNTAX
```powershell
Disconnect-Entra
 [<CommonParameters>]
```

## DESCRIPTION
The Disconnect-Entra cmdlet disconnects the current session from a Microsoft Entra ID tenant.

## EXAMPLES

### Example 1: Disconnect your session from a tenant

```powershell
PS C:\> Disconnect-Entra
```
```output
ClientId               : 8886ad7b-1795-4542-9808-c85859d97f23
TenantId               : d5aec55f-2d12-4442-8d2f-ccca95d4390e
Scopes                 : {Agreement.ReadWrite.All, Policy.ReadWrite.IdentityProtection, CustomSecAttributeDefinition.ReadWrite.All, TeamMember.Read.All...}
AuthType               : AppOnly
TokenCredentialType    : ClientCertificate
CertificateThumbprint  : F8813914053FBFB5D84F1EFA9EDB3205621C1126
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

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-Entra](Connect-Entra.md)