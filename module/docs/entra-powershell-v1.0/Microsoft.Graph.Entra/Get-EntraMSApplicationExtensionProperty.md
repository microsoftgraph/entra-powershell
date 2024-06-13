---
title: Get-EntraMSApplicationExtensionProperty
description: This article provides details on the Get-EntraMSApplicationExtensionProperty command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSApplicationExtensionProperty

## Synopsis
Retrieves the list of extension properties on an application object.

## Syntax

```powershell
Get-EntraMSApplicationExtensionProperty 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
Retrieves the list of extension properties on an application object.

## Examples

### Example 1: Get extension properties.
```powershell
PS C:\>Get-EntraMSApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

```output
DeletedDateTime Id                                   AppDisplayName DataType IsSyncedFromOnPremises Name                                                     TargetObjects
--------------- --                                   -------------- -------- ---------------------- ----                                                     -------------
                9978e52f-1499-4a11-aead-95df460ffa0b                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute2 {}
                76ff06dc-65cb-4a9b-bf66-5b8e20aa8abf                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute1 {}
                b901db71-2d86-454b-b2f7-fd1dfbfceac9                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute  {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

## Parameters

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### string
## Outputs

### Microsoft.Open.MSGraph.Model.GetExtensionPropertiesResponse
## Notes

## Related LINKS

[New-EntraMSApplicationExtensionProperty](New-EntraMSApplicationExtensionProperty.md)

[Remove-EntraMSApplicationExtensionProperty](Remove-EntraMSApplicationExtensionProperty.md)

