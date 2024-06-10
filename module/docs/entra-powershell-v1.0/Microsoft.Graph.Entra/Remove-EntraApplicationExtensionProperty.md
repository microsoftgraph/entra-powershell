---
title: Remove-EntraApplicationExtensionProperty.
description: This article provides details on the Remove-EntraApplicationExtensionProperty command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationExtensionProperty

## SYNOPSIS
Removes an application extension property.

## SYNTAX

```powershell
Remove-EntraApplicationExtensionProperty 
 -ExtensionPropertyId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraApplicationExtensionProperty cmdlet removes an application extension property for an object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application extension property
```
PS C:\> Remove-EntraApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -ExtensionPropertyId "344ed560-f8e7-410e-ab9f-c79df5c36"
```

This command removes the extension property that has the specified ID from an application in Microsoft Entra ID.

## PARAMETERS

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplicationExtensionProperty](Get-EntraApplicationExtensionProperty.md)

[New-EntraApplicationExtensionProperty](New-EntraApplicationExtensionProperty.md)

