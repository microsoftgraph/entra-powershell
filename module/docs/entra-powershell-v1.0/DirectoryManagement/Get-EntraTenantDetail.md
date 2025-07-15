---
author: msewaweru
description: This article provides details on the Get-EntraTenantDetail command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraTenantDetail
schema: 2.0.0
title: Get-EntraTenantDetail
---

# Get-EntraTenantDetail

## SYNOPSIS

Gets the details of a tenant.

## SYNTAX

```powershell
Get-EntraTenantDetail
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraTenantDetail` cmdlet gets the details of a tenant in Microsoft Entra ID.

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

This example shows how to retrieve all tenant details.

### Example 2: Get all licenses in the tenant

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTenantDetail | Select-Object -ExpandProperty ProvisionedPlans
```

```Output
CapabilityStatus ProvisioningStatus Service                       AdditionalProperties
---------------- ------------------ -------                       --------------------
Enabled          Success            SharePoint
Enabled          Success            exchange
Enabled          Success            exchange
Enabled          Success            exchange
Enabled          Success            SCO
Enabled          Success            exchange
Enabled          Success            SharePoint
Enabled          Success            CloudPC-MX
Enabled          Success            YammerEnterprise
```

This example shows how to retrieve all licenses in the tenant.

### Example 3: Get top one tenant details

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTenantDetail -Top 1
```

```Output
DisplayName Id                                   CountryLetterCode VerifiedDomains
----------- --                                   ----------------- ---------------
Contoso     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb NL                {@{Capabilities=Email, OfficeCommunicationsOnline; IsDefault=False; IsInitial=True; Name=contoso.onmicrosoft.com; Type=Managed; Addition…}}
```

This example shows how to retrieve details of a top one tenant in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get directory tenant size quota

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
(Get-EntraTenantDetail).AdditionalProperties.directorySizeQuota
```

```Output
Key   Value
---   -----
used    339
total 50000
```

This example shows how to retrieve the directory tenant size quota.

A directory quota represents the maximum number of objects allowed in a tenant, including user accounts, app registrations, and groups. Once this limit is reached, attempts to create new objects will result in an error.

## PARAMETERS

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
Aliases: Limit

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
Aliases: Select

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

[Set-EntraTenantDetail](Set-EntraTenantDetail.md)
