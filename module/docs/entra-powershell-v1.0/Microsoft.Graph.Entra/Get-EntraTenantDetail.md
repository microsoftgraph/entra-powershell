---
title: Get-EntraTenantDetail.
description: This article provides details on the Get-EntraTenantDetail command.

ms.service: entra
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

## Synopsis
Gets the details of a tenant.

## Syntax

```powershell
Get-EntraTenantDetail 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description
The Get-EntraTenantDetail cmdlet gets the details of a tenant in Microsoft Entra ID.

## Examples

### Example 1: Get all tenant details 
```powershell
PS C:\> Get-EntraTenantDetail -All 
```
```output
DisplayName Id                                   TenantType CountryLetterCode VerifiedDomains
----------- --                                   ---------- ----------------- ---------------
Contoso     d5aec55f-2d12-4442-8d2f-ccca95d4390e AAD        NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=M365x99297270.onmicrosoft.com; Type=Mana...
```

This example demonstrates how to retrieve details of all tenants in Microsoft Entra ID.  
This command gets all tenant details.

### Example 2: Get top five tenant details 
```powershell
Get-EntraTenantDetail -Top 5
```
```output
DisplayName Id                                   TenantType CountryLetterCode VerifiedDomains
----------- --                                   ---------- ----------------- ---------------
Contoso     d5aec55f-2d12-4442-8d2f-ccca95d4390e AAD        NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=M365x99297270.onmicrosoft.com; Type=Mana...
```

This example demonstrates how to retrieve details of a top five tenants in Microsoft Entra ID.  
This command gets five tenant details.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Set-EntraTenantDetail](Set-EntraTenantDetail.md)