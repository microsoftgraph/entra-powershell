---
author: msewaweru
description: This article provides details on the New-EntraDomain command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraDomain
schema: 2.0.0
title: New-EntraDomain
---

# New-EntraDomain

## SYNOPSIS

Creates a domain.

## SYNTAX

```powershell
New-EntraDomain
 -Name <String>
 [-IsDefault <Boolean>]
 [-SupportedServices <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraDomain` cmdlet creates a domain in Microsoft Entra ID.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Domain Name Administrator

## EXAMPLES

### Example 1: Create a new Domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraDomain -Name testingDemo.com
```

```Output
Id              AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--              ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain in Microsoft Entra ID.

### Example 2: Create a new Domain with a list of domain capabilities

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraDomain -Name testingDemo1.com -SupportedServices @('Email', 'OfficeCommunicationsOnline')
```

```Output
Id               AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--               ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo1.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain with the specified services in Microsoft Entra ID.

### Example 3: Create a new Domain and make if the default new user creation

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraDomain -Name testingDemo2.com -IsDefault $True
```

```Output
Id               AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--               ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo2.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain in Microsoft Entra ID and marks it as the default to be used for new user creation.

## PARAMETERS

### -IsDefault

Indicates whether or not this is the default domain that is used for user creation.

There is only one default domain per company.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The fully qualified name of the domain.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SupportedServices

The capabilities assigned to the domain.

```yaml
Type: System.Collections.Generic.List`1[System.String]
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[Get-EntraDomain](Get-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
