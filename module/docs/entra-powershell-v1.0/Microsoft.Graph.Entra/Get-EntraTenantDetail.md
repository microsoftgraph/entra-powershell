---
title: Get-EntraTenantDetail
description: This article provides details on the Get-EntraTenantDetail command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraTenantDetail

schema: 2.0.0
---

# Get-EntraTenantDetail

## Synopsis

Gets the details of a tenant.

## Syntax

```powershell
Get-EntraTenantDetail
 [-All <Boolean>]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraTenantDetail` cmdlet gets the details of a tenant in Microsoft Entra ID.

## Examples

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

This example shows how to retrieve all tenant details.

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

This example shows how to retrieve details of a top five tenants in Microsoft Entra ID.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
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

### -Property

Specifies properties to be returned

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

## Related Links

[Set-EntraTenantDetail](Set-EntraTenantDetail.md)
