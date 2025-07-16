---
author: msewaweru
description: This article provides details on the Set-EntraBetaDomain command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/09/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaDomain
schema: 2.0.0
title: Set-EntraBetaDomain
---

# Set-EntraBetaDomain

## SYNOPSIS

Updates a domain.

## SYNTAX

```powershell
Set-EntraBetaDomain
 -Name <String>
 [-IsDefault <Boolean>]
 [-SupportedServices <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaDomain` cmdlet updates a verified domain in Microsoft Entra ID.

The work or school account needs to belong to at least one of the following Microsoft Entra roles:

- Domain Name Administrator
- Security Administrator
- External Identity Provider Administrator

## EXAMPLES

### Example 1: Set the domain as the default domain for new user account creation

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Set-EntraBetaDomain -Name Contoso.com -IsDefault $true
```

This example demonstrates how to set default domain for new user account in Microsoft Entra ID.  

### Example 2: Set the list of domain capabilities

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Set-EntraBetaDomain -Name Contoso.com -SupportedServices @('Email', 'OfficeCommunicationsOnline')
```

This example demonstrates how to set domain capabilities for new user account in Microsoft Entra ID.  

## PARAMETERS

### -IsDefault

Indicates whether or not this is the default domain that is used for user creation.
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

[Confirm-EntraBetaDomain](Confirm-EntraBetaDomain.md)

[Get-EntraBetaDomain](Get-EntraBetaDomain.md)

[New-EntraBetaDomain](New-EntraBetaDomain.md)

[Remove-EntraBetaDomain](Remove-EntraBetaDomain.md)
