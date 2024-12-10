---
title: Get-EntraBetaServicePrincipalMembership
description: This article provides details on the Get-EntraBetaServicePrincipalMembership command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalMembership

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalMembership

## Synopsis

Get a service principal membership.

## Syntax

```powershell
Get-EntraBetaServicePrincipalMembership
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalMembership` cmdlet gets the memberships of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalMembership -ServicePrincipalId $servicePrincipal.Id
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
11112222-aaaa-3333-bbbb-4444cccc5555
```

This cmdlet retrieves a specified service principal memberships in Microsoft Entra ID. You can use the command `Get-EntraBetaServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Retrieve all memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalMembership -ServicePrincipalId $servicePrincipal.Id -All 
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
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalMembership -ServicePrincipalId $servicePrincipal.Id -Top 2
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

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)