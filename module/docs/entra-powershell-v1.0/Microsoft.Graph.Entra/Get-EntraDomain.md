---
title: Get-EntraDomain
description: This article provides details on the Get-EntraDomain command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomain

## SYNOPSIS
Gets a domain.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraDomain 
    [<CommonParameters>]
```

### GetById
```powershell
Get-EntraDomain 
    -Name <String> 
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraDomain** cmdlet gets a domain in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a list of Domains that are created.
```powershell
PS C:\>Get-EntraDomain
```

```output
Id         AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--         ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
TEST22.com Managed                               True           False     False     False  False                                                                                       {}
test26.com Managed                               True           False     False     False  False                                                                                       {}
test25.com Managed                               True           False     False     False  False                                                                                       {}
```

This command retrieves a list of domains.

### Example 2: Get a specific Domain.
```powershell
PS C:\>Get-EntraDomain -Name TEST22.com
```

```output
Id         AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--         ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
TEST22.com Managed                               True           False     False     False  False                                                                                       {}
```

This command retrieves a domain with the specified name.

## PARAMETERS

### -Name
Specifies the name of a domain.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)

