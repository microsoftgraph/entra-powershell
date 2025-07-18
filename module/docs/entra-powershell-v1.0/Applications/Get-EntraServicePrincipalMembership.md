---
author: msewaweru
description: This article provides details on the Get-EntraServicePrincipalMembership command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraServicePrincipalMembership
schema: 2.0.0
title: Get-EntraServicePrincipalMembership
---

# Get-EntraServicePrincipalMembership

## SYNOPSIS

Get a service principal membership.

## SYNTAX

```powershell
Get-EntraServicePrincipalMembership
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraServicePrincipalMembership` cmdlet gets the memberships of a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $servicePrincipal.Id | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName         @odata.type
--                                   -----------         -----------
11112222-aaaa-3333-bbbb-4444cccc5555 Sales and Marketing #microsoft.graph.group
```

This cmdlet retrieves a specified service principal memberships in Microsoft Entra ID. You can use the command `Get-EntraServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Retrieve all memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $ServicePrincipal.Id -All | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName         @odata.type
--                                   -----------         -----------
11112222-aaaa-3333-bbbb-4444cccc5555 Sales and Marketing #microsoft.graph.group
```

This command gets all memberships of a specified service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 3: Retrieve top two memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $ServicePrincipal.Id -Top 2 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName         @odata.type
--                                   -----------         -----------
11112222-aaaa-3333-bbbb-4444cccc5555 Sales and Marketing #microsoft.graph.group
```

This command gets top two memberships of a specified service principal. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the service principal ID.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

Specifies properties to be returned

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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
