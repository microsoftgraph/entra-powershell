---
title:  Get-EntraBetaServicePrincipalOwnedObject.
description: This article provides details on the  Get-EntraBetaServicePrincipalOwnedObject Command.

ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalOwnedObject

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalOwnedObject

## Synopsis

Gets an object owned by a service principal.

## Syntax

```powershell
Get-EntraBetaServicePrincipalOwnedObject
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalOwnedObject` cmdlet gets an object owned by a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owned objects of a service principal

```powershell
 Connect-Entra -Scopes 'Application.Read.All'
 $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
 Get-EntraBetaServicePrincipalOwnedObject -ObjectId $ServicePrincipalId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example retrieves an object owned by a service principal in Microsoft Entra ID. You can use the command `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ObjectId` parameter specifies the service principal object ID.

### Example 2: Retrieve all the owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaServicePrincipalOwnedObject -ObjectId '11112222-bbbb-3333-cccc-4444dddd5555' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example retrieves all owned objects of a specified service principal in Microsoft Entra ID.

- `-ObjectId` parameter specifies the service principal object ID.

### Example 3: Retrieve top one owned object of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaServicePrincipalOwnedObject -ObjectId '11112222-bbbb-3333-cccc-4444dddd5555' -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example retrieves the top one owned object of a specified service principal in Microsoft Entra ID.

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

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)
