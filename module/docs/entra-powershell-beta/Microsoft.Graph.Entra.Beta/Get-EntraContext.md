---
title: Get-EntraContext
description: This article provides details on the Get-EntraContext command.


ms.topic: reference
ms.date: 07/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutung
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraContext

schema: 2.0.0
---

# Get-EntraContext

## Synopsis

Retrieve information about your current session.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraContext
 [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
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

### -ProgressAction

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

Please note that `Get-EntraCurrentSessionInfo` is now an alias for `Get-EntraContext` and can be used interchangeably.

## Related Links
