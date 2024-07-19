---
title: Get-EntraBetaObjectByObjectId
description: This article provides details on the Get-EntraBetaObjectByObjectId.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaObjectByObjectId

## Synopsis
Retrieves the objects specified by the ObjectIds parameter

## Syntax
```powershell
Get-EntraBetaObjectByObjectId 
 [-Types <System.Collections.Generic.List`1[System.String]>]
 -ObjectIds <System.Collections.Generic.List`1[System.String]> 
 [<CommonParameters>]
```
## Description
Retrieves the objects specified by the ObjectIds parameter

## Examples

### Example 1: Get an object One or more object IDs.
```powershell
PS C:\WINDOWS\system32> Get-EntraBetaObjectByObjectId -ObjectIds 2af3478a-27da-4837-a387-b22b3fb236a8, c4fdf87f-f68e-4859-8bcf-36579b66005e
```
```output
Id                                   DeletedDateTime
--                                   ---------------
b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e
```

 This example two objects are retrieved (a DeviceConfiguration object and an Application object) as specified by the value of the ObjectIds parameter.

### Example 2: Get an object by types
```powershell
PS C:\> Get-EntraBetaObjectByObjectId -ObjectIds b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e -Types User
```
```output
Id                                   DeletedDateTime
--                                   ---------------
b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e
```
This example demonstrates how to retrieve objects for a specified object type.

## Parameters

### -ObjectIds
One or more object IDs's, separated by commas, for which the objects are retrieved.

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

## Inputs

### None
## Outputs

### System.Object
## Notes

## Related Links
