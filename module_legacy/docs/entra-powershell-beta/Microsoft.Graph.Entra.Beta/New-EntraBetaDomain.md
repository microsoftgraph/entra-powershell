---
title: New-EntraBetaDomain
description: This article provides details on the New-EntraBetaDomain command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaDomain

schema: 2.0.0
---

# New-EntraBetaDomain

## Synopsis

Creates a domain.

## Syntax

```powershell
New-EntraBetaDomain
 -Name <String>
 [-IsDefault <Boolean>]
 [-SupportedServices <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaDomain` cmdlet creates a domain in Microsoft Entra ID.

The work or school account needs to belong to at least the Domain Name Administrator role.

## Examples

### Example 1: Create a new Domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraBetaDomain -Name test22.com 
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
```

This example demonstrates how to create a new domain in Microsoft Entra ID.

### Example 2: Create a new Domain with a list of domain capabilities

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraBetaDomain -Name test22.com -SupportedServices @('Email', 'OfficeCommunicationsOnline')
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
```

This example demonstrates how to create a new domain with the specified services in Microsoft Entra ID.

### Example 3: Create a new Domain and make if the default new user creation

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
New-EntraBetaDomain -Name test22.com -IsDefault $true
```

```Output
Id          AuthenticationType AvailabilityStatus IsAdminManaged IsDefault IsInitial IsRoot IsVerified PasswordNotificationWindowInDays
--          ------------------ ------------------ -------------- --------- --------- ------ ---------- --------------------------------
test22.com  Managed                               True           False     False     False  False      13
```

This example demonstrates how to create a new domain in Microsoft Entra ID and marks it as the default to be used for new user creation.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[Confirm-EntraBetaDomain](Confirm-EntraBetaDomain.md)

[Get-EntraBetaDomain](Get-EntraBetaDomain.md)

[Remove-EntraBetaDomain](Remove-EntraBetaDomain.md)

[Set-EntraBetaDomain](Set-EntraBetaDomain.md)
