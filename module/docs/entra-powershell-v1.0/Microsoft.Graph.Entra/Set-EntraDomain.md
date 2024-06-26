---
title: Set-EntraDomain.
description: This article provides details on the Set-EntraDomain command.

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

# Set-EntraDomain

## SYNOPSIS

Updates a domain.

## SYNTAX

```powershell
Set-EntraDomain 
 -Name <String>
 [-IsDefault <Boolean>]
 [-SupportedServices <System.Collections.Generic.List`1[System.String]>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraDomain` cmdlet updates a domain in Microsoft Entra ID.

The work or school account needs to belong to at least one of the following Microsoft Entra roles:

- Domain Name Administrator
- Security Administrator
- External Identity Provider Administrator

## EXAMPLES

### Example 1: Set the domain as the default domain for new user account creation

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Set-EntraDomain -Name Contoso.com -IsDefault $true
```

This example demonstrates how to set default domain for new user account in Microsoft Entra ID.  

### Example 2: Set the list of domain capabilities

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Set-EntraDomain -Name Contoso.com -SupportedServices @('Email', 'OfficeCommunicationsOnline')
```

This example demonstrates how to set domain capabilities for new user account in Microsoft Entra ID.  

## PARAMETERS

### -IsDefault

Indicates whether or not this is the default domain used for user creation.
There's only one default domain per company.

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
Accept pipeline input: True (ByPropertyName, ByValue)
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

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)
