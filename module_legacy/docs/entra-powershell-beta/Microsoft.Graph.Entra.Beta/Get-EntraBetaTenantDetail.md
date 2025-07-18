---
title: Get-EntraBetaTenantDetail
description: This article provides details on the Get-EntraBetaTenantDetail command.


ms.topic: reference
ms.date: 08/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaTenantDetail

schema: 2.0.0
---

# Get-EntraBetaTenantDetail

## Synopsis

Gets the details of a tenant.

## Syntax

```powershell
Get-EntraBetaTenantDetail
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaTenantDetail` cmdlet gets the details of a tenant in Microsoft Entra ID.

In delegated scenarios involving work or school accounts, the signed-in user must be assigned either a supported Microsoft Entra role or a custom role with the necessary permissions. The following least-privileged roles are supported for this operation:

- Application Administrator
- Authentication Administrator
- Cloud Application Administrator
- Directory Readers
- Directory Reviewer
- Global Reader
- Helpdesk Administrator
- Security Administrator
- Security Operator
- Security Reader
- Service Support Administrator
- User Administrator
- Privileged Role Administrator

## Examples

### Example 1: Get all tenant details

```powershell
Connect-Entra -Scopes 'Organization.Read.All' 
Get-EntraBetaTenantDetail -All
```

```Output
DisplayName Id                                   CountryLetterCode VerifiedDomains
----------- --                                   ----------------- ---------------
Contoso     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Managed; Addition…}}
Contoso1    bbbbbbbb-1111-2222-3333-cccccccccccc NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Managed; Addition…}}
```

This example shows how to retrieve all tenant details.

### Example 2: Get top one tenant details

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaTenantDetail -Top 1
```

```Output
DisplayName Id                                   CountryLetterCode VerifiedDomains
----------- --                                   ----------------- ---------------
Contoso     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Managed; Addition…}}
```

This example shows how to retrieve details of a top one tenant in Microsoft Entra ID.

### Example 3: Get directory tenant size quota

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
(Get-EntraBetaTenantDetail).AdditionalProperties.directorySizeQuota
```

```Output
Key   Value
---   -----
used    339
total 50000
```

This example shows how to retrieve the directory tenant size quota.

A directory quota represents the maximum number of objects allowed in a tenant, including user accounts, app registrations, and groups. Once this limit is reached, attempts to create new objects will result in an error.

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

Specifies properties to be returned.

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

[Set-EntraBetaTenantDetail](Set-EntraBetaTenantDetail.md)
