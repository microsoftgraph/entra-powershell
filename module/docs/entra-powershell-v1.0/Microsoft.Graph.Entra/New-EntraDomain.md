---
title: New-EntraDomain.
description: This article provides details on the New-EntraDomain command.

ms.service: entra
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
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
The New-EntraDomain cmdlet creates a domain in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a new Domain
```powershell
PS C:\>New-EntraDomain -Name testingDemo.com
```
```output
Id              AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--              ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain in Microsoft Entra ID.   
This command creates a new domain.

### Example 2: Create a new Domain with a list of domain capabilities
```powershell
PS C:\>New-EntraDomain -Name testingDemo1.com -SupportedServices @("Email", "OfficeCommunicationsOnline")
```
```output
Id               AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--               ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo1.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain with the specified services in Microsoft Entra ID.  
This command creates a new domain with the specified services for this domain.

### Example 3: Create a new Domain and make if the default new user creation
```powershell
PS C:\>New-EntraDomain -Name testingDemo2.com -IsDefault $True
```
```output
Id               AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified Manufacturer Model PasswordNotificationWindowInDays PasswordValidityPeriodInDays SupportedServices
--               ------------------ ------------------ -------------- --------- --------- ------ ---------- ------------ ----- -------------------------------- ---------------------------- -----------------
testingDemo2.com Managed                               True           False     False     False  False                                                                                       {}
```

This example demonstrates how to create a new domain in Microsoft Entra ID.   
This command creates a new domain and marks it as the default to be used for new user creation.

## PARAMETERS

### -IsDefault
Indicates whether or not this is the default domain that is used for user creation.
There's only one default domain per company.

```yaml
Type: Boolean
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
Type: String
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[Get-EntraDomain](Get-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)

