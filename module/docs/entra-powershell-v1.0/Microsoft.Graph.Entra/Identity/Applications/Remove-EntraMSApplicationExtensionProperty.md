---
title: Remove-EntraMSApplicationExtensionProperty.
description: This article provides details on the Remove-EntraMSApplicationExtensionProperty command.

ms.service: entra
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

# Remove-EntraMSApplicationExtensionProperty

## SYNOPSIS
Deletes an extension property from an application object.

## SYNTAX

```powershell
Remove-EntraMSApplicationExtensionProperty 
 -ExtensionPropertyId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Deletes an extension property from an application object.

## EXAMPLES

### Example 1: Remove an extension property
```powershell
PS C:\> Remove-EntraMSApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -ExtensionPropertyId "344ed560-f8e7-410e-ab9f-c79df5c36"
```

This command removes the extension property that has the specified ID from an application in Microsoft Entra ID.
- ObjectId:  The ObjectId of the specified Application.
- ExtensionPropertyId: The unique ID of the extension property to remove.

## PARAMETERS

### -ObjectId
Specifies the unique ID of an application in Microsoft Entra ID.

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

### -ExtensionPropertyId
Specifies the unique ID of the extension property to remove.

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

## INPUTS

### String
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSApplicationExtensionProperty](Get-EntraMSApplicationExtensionProperty.md)

[New-EntraMSApplicationExtensionProperty](New-EntraMSApplicationExtensionProperty.md)

