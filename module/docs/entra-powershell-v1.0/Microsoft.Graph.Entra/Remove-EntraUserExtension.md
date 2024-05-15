---
title: Remove-EntraUserExtension.
description: This article provides details on the Remove-EntraUserExtension command.

ms.service: entra
ms.subservice: powershell
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

# Remove-EntraUserExtension

## SYNOPSIS
Removes a user extension.

## SYNTAX

### SetMultiple
```powershell
Remove-EntraUserExtension 
 -ObjectId <String> 
 -ExtensionNames <System.Collections.Generic.List`1[System.String]>
 [<CommonParameters>]
```

### SetSingle
```powershell
Remove-EntraUserExtension 
 -ObjectId <String> 
 -ExtensionName <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraUserExtension cmdlet removes a user extension from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the "Test Extension" attribute from user: TestUser@example.com
```powershell
PS C:\> Remove-EntraUserExtension -ObjectId TestUser@example.com -ExtensionName "Test Extension"
```

This will remove the "Test Extension" attribute from user: TestUser@example.com.

## PARAMETERS

### -ExtensionName
Specifies the name of an extension.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNames
Specifies an array of extension names.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies an object ID.

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

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Set-EntraUserExtension](Set-EntraUserExtension.md)

