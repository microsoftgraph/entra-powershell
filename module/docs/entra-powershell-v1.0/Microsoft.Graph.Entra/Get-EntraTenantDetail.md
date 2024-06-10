---
title: Get-EntraTenantDetail.
description: This article provides details on the Get-EntraTenantDetail command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraTenantDetail

## SYNOPSIS

Gets the details of a tenant.

## SYNTAX

```powershell
Get-EntraTenantDetail 
 [-All <Boolean>]
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraTenantDetail` cmdlet gets the details of a tenant in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get all tenant details 

```powershell
Connect-Entra -Scopes 'Organization.Read.All' 
Get-EntraTenantDetail -All 
```

```Output
DisplayName Id                                   TenantType CountryLetterCode VerifiedDomains
----------- --                                   ---------- ----------------- ---------------
Contoso     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AAD        NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Mana...
```

This example explains how to retrieve details of all tenants in Microsoft Entra ID.  
This command gets all tenant details.

### Example 2: Get top five tenant details 

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTenantDetail -Top 5
```

```Output
DisplayName Id                                   TenantType CountryLetterCode VerifiedDomains
----------- --                                   ---------- ----------------- ---------------
Contoso     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AAD        NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Mana...
```

This example explains how to retrieve details of a top five tenants in Microsoft Entra ID.  
This command gets five tenant details.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraTenantDetail](Set-EntraTenantDetail.md)