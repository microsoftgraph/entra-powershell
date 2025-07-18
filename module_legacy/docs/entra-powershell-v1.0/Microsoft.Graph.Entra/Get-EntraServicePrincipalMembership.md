---
title: Get-EntraServicePrincipalMembership
description: This article provides details on the Get-EntraServicePrincipalMembership command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalMembership

schema: 2.0.0
---

# Get-EntraServicePrincipalMembership

## Synopsis

Get a service principal membership.

## Syntax

```powershell
Get-EntraServicePrincipalMembership
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalMembership` cmdlet gets the memberships of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $ServicePrincipal.ObjectId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
11112222-aaaa-3333-bbbb-4444cccc5555
```

This cmdlet retrieves a specified service principal memberships in Microsoft Entra ID. You can use the command `Get-EntraServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Retrieve all memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $ServicePrincipal.ObjectId -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
11112222-aaaa-3333-bbbb-4444cccc5555
22223333-cccc-4444-dddd-5555eeee6666
33334444-dddd-5555-eeee-6666ffff7777
```

This command gets all memberships of a specified service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 3: Retrieve top two memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalMembership -ServicePrincipalId $ServicePrincipal.ObjectId -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
11112222-aaaa-3333-bbbb-4444cccc5555
22223333-cccc-4444-dddd-5555eeee6666

```

This command gets top two memberships of a specified service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.

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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
