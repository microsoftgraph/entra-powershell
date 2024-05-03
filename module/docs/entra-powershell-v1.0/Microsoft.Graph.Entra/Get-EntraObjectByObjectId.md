---
title: Get-EntraObjectByObjectId.
description: This article provides details on the Get-EntraObjectByObjectId command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraObjectByObjectId

## SYNOPSIS
Retrieves the object(s) specified by the ObjectIds parameter.

## SYNTAX

```powershell
Get-EntraObjectByObjectId 
 -ObjectIds <System.Collections.Generic.List`1[System.String]>
 [-Types <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the object(s) specified by the ObjectIds parameter.

## EXAMPLES

### Example 1: Get an object by ID
```powershell
PS C:\WINDOWS\system32> Get-EntraObjectByObjectId -ObjectIds 2af3478a-27da-4837-a387-b22b3fb236a8, c4fdf87f-f68e-4859-8bcf-36579b66005e
```

This example demonstrates how to retrieve objects specified by the ObjectIds.

### Example 2: Get an object by types
```powershell
PS C:\> Get-EntraObjectByObjectId -ObjectIds b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e -Types Group
```

This example demonstrates how to retrieve objects for a specified object type.

## PARAMETERS

### -ObjectIds
One or more object IDs, separated by commas, for which the objects are retrieved.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Types
Specifies the type of objects that the cmdlet returns.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
