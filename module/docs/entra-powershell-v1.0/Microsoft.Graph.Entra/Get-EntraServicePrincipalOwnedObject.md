---
title:  Get-EntraServicePrincipalOwnedObject.
description: This article provides details on the  Get-EntraServicePrincipalOwnedObject Command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
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

## SYNOPSIS
Gets an object owned by a service principal.

## SYNTAX

```powershell
Get-EntraServicePrincipalOwnedObject 
 [-All] 
 -ObjectId <String> 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraServicePrincipalOwnedObject cmdlet gets an object owned by a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the owned objects of a service principal

```powershell
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServicePrincipalOwnedObject -ObjectId $ServicePrincipalId
```

```output
Id                                   DeletedDateTime
--                                   ---------------
02939955-b5d0-436e-a8b1-35d37154f550
3dfbf14c-cdc9-433d-ae2a-30e7806ef956
```

The first command gets the ID of a service principal by using the [Get-EntraServicePrincipal](./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the owned objects of a service principal identified by $ServicePrincipalId.  

### Example 2: Retrieve all the owned objects of a service principal
```powershell
PS C:\> Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
02939955-b5d0-436e-a8b1-35d37154f550
3dfbf14c-cdc9-433d-ae2a-30e7806ef956
```

This command gets the owned objects of a service principal identified by `2d028fff-7e65-4340-80ca-89be16dae0b3`.  

### Example 3: Retrieve top one owned object of a service principal
```powershell
PS C:\> Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3" -Top 1
```

```output
Id                                   DeletedDateTime
--                                   ---------------
02939955-b5d0-436e-a8b1-35d37154f550
```

This command gets top one owned object of a service principal identified by `2d028fff-7e65-4340-80ca-89be16dae0b3`.  

## PARAMETERS

### -All
List all pages.

```yaml
Type: SwitchParameter
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
Type: String
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)