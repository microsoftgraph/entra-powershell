---
description: This article provides details on the Get-EntraDomain command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDomain
schema: 2.0.0
title: Get-EntraDomain
---

# Get-EntraDomain

## SYNOPSIS

Gets a domain.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraDomain
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDomain
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDomain` cmdlet gets a domain in Microsoft Entra ID.

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

## EXAMPLES

### Example 1: Get a list of Domains that are created

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraDomain
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
Get-EntraDomain -Name TEST22.com
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
```

This command retrieves a domain with the specified name.

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
