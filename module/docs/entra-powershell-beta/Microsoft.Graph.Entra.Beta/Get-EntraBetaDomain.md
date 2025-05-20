---
title: Get-EntraBetaDomain
description: This article provides details on the Get-EntraBetaDomain command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomain

schema: 2.0.0
---

# Get-EntraBetaDomain

## Synopsis

Gets a domain.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDomain
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDomain
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDomain` cmdlet gets a domain in Microsoft Entra ID.

The work or school account must be assigned to at least one of the following Microsoft Entra roles:

- User Administrator
- Helpdesk Administrator
- Service Support Administrator
- Directory Readers
- AdHoc License Administrator
- Application Administrator
- Security Reader
- Security Administrator
- Privileged Role Administrator
- Cloud Application Administrator

## Examples

### Example 1: Get a list of Domains that are created

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomain
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
test33.com  Managed                               True           False     False     False  False      15
test44.com  Managed                               True           False     False     False  False      17
```

This command retrieves a list of domains.

### Example 2: Get a specific Domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomain -Name TEST22.com
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
```

This command retrieves a domain with the specified name.

## Parameters

### -Name

Specifies the name of a domain.

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

## Outputs

## Notes

## Related links

[Confirm-EntraBetaDomain](Confirm-EntraBetaDomain.md)

[New-EntraBetaDomain](New-EntraBetaDomain.md)

[Remove-EntraBetaDomain](Remove-EntraBetaDomain.md)

[Set-EntraBetaDomain](Set-EntraBetaDomain.md)
