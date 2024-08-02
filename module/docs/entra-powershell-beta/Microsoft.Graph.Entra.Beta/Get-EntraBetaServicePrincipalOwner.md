---
title: Get-EntraBetaServicePrincipalOwner
description: This article provides details on the Get-EntraBetaServicePrincipalOwner command.

ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalOwner

## Synopsis

Get the owner of a service principal.

## Syntax

```powershell
Get-EntraBetaServicePrincipalOwner
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalOwner` cmdlet gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example gets the owners of a specified service principal. You can use the comand `Get-EntraBetaServicePrincipal` to get service principal object Id.

- `ObjectId` parameter specifies the service principal object ID.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This command gets all the owners of a service principal. You can use the comand `Get-EntraBetServicePrincipal` to get service principal object Id.

- `ObjectId` parameter specifies the service principal object ID.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This command gets top two owners of a service principal. You can use the comand `Get-EntraBetServicePrincipal` to get service principal object Id.

- `-ObjectId` parameter specifies the service principal object ID.

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

### -ObjectId

Specifies the ID of a service principal in Microsoft Entra ID.

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

[Add-EntraBetaServicePrincipalOwner](Add-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Remove-EntraBetaServicePrincipalOwner](Remove-EntraBetaServicePrincipalOwner.md)
