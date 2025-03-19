---
title: Get-EntraBetaPasswordPolicy
description: This article provides details on the Get-EntraBetaPasswordPolicy command.


ms.topic: reference
ms.date: 08/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaPasswordPolicy

schema: 2.0.0
---

# Get-EntraBetaPasswordPolicy

## Synopsis

Retrieves the current password policy for the tenant or the specified domain.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaPasswordPolicy
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPasswordPolicy
 -DomainName <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaPasswordPolicy` cmdlet can be used to retrieve the values associated with the Password Expiry
window or Password Expiry Notification window for a tenant or specified domain.

When a domain name is specified, it must be a verified domain for the company.

The work or school account needs to belong to one of the following Microsoft Entra roles:

- Domain Name Administrator

## Examples

### Example 1: Get password policy for a specified domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaPasswordPolicy -DomainName 'contoso.com'
```

```Output
NotificationDays ValidityPeriod
---------------- --------------
            90             180
```

Returns the password policy for the specified domain.

- `-DomainName` parameter specifies the fully qualified domain name to retrieve.

## Parameters

### -DomainName

The fully qualified name of the domain to be retrieved.

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

## Outputs

## Notes

## Related Links
