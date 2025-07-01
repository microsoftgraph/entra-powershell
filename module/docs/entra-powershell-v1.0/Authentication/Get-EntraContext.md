---
author: msewaweru
description: This article provides details on the Get-EntraContext command.
external help file: Microsoft.Entra.Authentication-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraContext
schema: 2.0.0
title: Get-EntraContext
---

# Get-EntraContext

## Synopsis

Retrieve information about your current session

## Syntax

### GetQuery (Default)

```powershell
Get-EntraContext [<CommonParameters>]
```

## Description

`Get-EntraContext` is used to retrieve the details about your current session, which include:

- ClientID
- TenantID
- Certificate Thumbprint
- Scopes consented to
- AuthType: Delegated or app-only
- AuthProviderType
- CertificateName
- Account
- AppName
- ContextScope
- Certificate
- PSHostVersion
- ClientTimeOut.

`Get-EntraCurrentSessionInfo` is an alias for `Get-EntraContext`.

## Examples

### Example 1: Get the current session

```powershell
Get-EntraContext
```

```Output
EntraPSModuleName     : Microsoft.Entra
EntraPSVersion        : 1.0.1
ClientId              : 11112222-bbbb-3333-cccc-4444dddd5555
TenantId              : aaaabbbb-0000-cccc-1111-dddd2222eeee
CertificateThumbprint :
Scopes                : {User.ReadWrite.All,...}
AuthType              : Delegated
AuthProviderType      : InteractiveAuthenticationProvider
CertificateName       :
Account               : SawyerM@Contoso.com
AppName               : Microsoft Graph PowerShell
ContextScope          : CurrentUser
Certificate           :
PSHostVersion         : 5.1.17763.1
ClientTimeout         : 00:05:00
```

This example demonstrates how to retrieve the details of the current session.

### Example 2: Get the current session scopes

```powershell
Get-EntraContext | Select -ExpandProperty Scopes
```

```Output
AppRoleAssignment.ReadWrite.All
Directory.AccessAsUser.All
EntitlementManagement.ReadWrite.All
Group.ReadWrite.All
openid
Organization.Read.All
profile
RoleManagement.ReadWrite.Directory
User.Read
User.ReadWrite.All
```

Retrieves all scopes.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links
