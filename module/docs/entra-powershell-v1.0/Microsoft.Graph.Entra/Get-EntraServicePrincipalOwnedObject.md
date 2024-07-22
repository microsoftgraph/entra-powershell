---
title:  Get-EntraServicePrincipalOwnedObject.
description: This article provides details on the  Get-EntraServicePrincipalOwnedObject Command.

ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipalOwnedObject

## Synopsis

Gets an object owned by a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalOwnedObject
 [-All]
 -ObjectId <String>
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalOwnedObject` cmdlet retrieves an object owned by a service principal in Microsoft Entra ID. Specify `ObjectId` parameter retrieve an object owned by a service principal.

## Examples

### Example 1: Retrieve the owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOwnedObject -ObjectId $ServicePrincipalId
```

```output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This command retrieves an object owned by a service principal.

- `-ObjectId` - Specifies the ID of a service principal.

### Example 2: Retrieve all the owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipalOwnedObject -ObjectId '11112222-bbbb-3333-cccc-4444dddd5555' -All 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This command gets the owned objects of a service principal identified by `11112222-bbbb-3333-cccc-4444dddd5555`.  

- `-ObjectId` - Specifies the ID of a service principal.

### Example 3: Retrieve top one owned object of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipalOwnedObject -ObjectId '11112222-bbbb-3333-cccc-4444dddd5555' -Top 1
```

```output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This command gets top one owned object of a service principal identified by `11112222-bbbb-3333-cccc-4444dddd5555`.  

- `-ObjectId` - Specifies the ID of a service principal.

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
