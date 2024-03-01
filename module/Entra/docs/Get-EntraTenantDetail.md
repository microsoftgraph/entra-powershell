---
title: Get-EntraTenantDetail.
description: This article provides details on the Get-EntraTenantDetail command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
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

```
Get-EntraTenantDetail 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraTenantDetail cmdlet gets the details of a tenant in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get details for a tenant
```
PS C:\>Get-EntraTenantDetail

DisplayName Id                                   TenantType CountryLetterCode VerifiedDomains
----------- --                                   ---------- ----------------- ---------------
Contoso     d5aec55f-2d12-4442-8d2f-ccca95d4390e AAD        NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=M365x99297270.onmicrosoft.com; Type=Mana...
```

This command gets a details for a tenant.

### Example 2: Get all tenant details 
```
PS C:\> Get-EntraTenantDetail -All $true
```

This command gets all tenant details.

### Example 3: Get top five tenant details 
```
Get-EntraTenantDetail -Top 5
```

This command gets five tenant details.

## PARAMETERS

### -All
If true, return all tenant details.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraTenantDetail]()