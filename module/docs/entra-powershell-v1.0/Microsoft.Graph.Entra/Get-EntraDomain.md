---
Title: Get-EntraDomain
Description: This article provides details on the Get-EntraDomain command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraDomain

## Synopsis

Gets a domain.

## Syntax

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

## Description

The `Get-EntraDomain` cmdlet gets a domain in Microsoft Entra ID.

## Examples

### Example 1: Get a list of Domains that are created

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraDomain
```

```Output
Id         AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--         ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
TEST22.com Managed                               True           False     False     False  False                                                                                       {}
Test26.com Managed                               True           False     False     False  False                                                                                       {}
Test25.com Managed                               True           False     False     False  False                                                                                       {}
```

This command retrieves a list of domains.

### Example 2: Get a specific Domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraDomain -Name TEST22.com
```

```Output
Id         AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--         ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
TEST22.com Managed                               True           False     False     False  False                                                                                       {}
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
