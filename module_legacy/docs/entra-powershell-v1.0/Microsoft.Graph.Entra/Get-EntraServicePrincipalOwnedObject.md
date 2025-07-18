---
title: Get-EntraServicePrincipalOwnedObject
description: This article provides details on the  Get-EntraServicePrincipalOwnedObject Command.


ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalOwnedObject

schema: 2.0.0
---

# Get-EntraServicePrincipalOwnedObject

## Synopsis

Gets an object owned by a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalOwnedObject
 [-All]
 -ServicePrincipalId <String>
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalOwnedObject` cmdlet retrieves an object owned by a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $ServicePrincipal.ObjectId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

The command retrieves the owned objects of a service principal.

- `-ServicePrincipalId` Parameter specifies the ID of a service principal.

### Example 2: Retrieve the all owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Filter "DisplayName eq '<user-display-name>'").ObjectId
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $ServicePrincipalId -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example retrieves an object owned by a service principal in Microsoft Entra ID. You can use the command `Get-EntraServicePrincipal` to get service principal Id.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

### Example 2: Retrieve all owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $ServicePrincipal.ObjectId -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

The command receives the all owned objects of a service principal.

- `-ServicePrincipalId` Parameter specifies the ID of a service principal.

### Example 3: Retrieve top one owned object of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $ServicePrincipal.ObjectId -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example retrieves the top one owned object of a specified service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
