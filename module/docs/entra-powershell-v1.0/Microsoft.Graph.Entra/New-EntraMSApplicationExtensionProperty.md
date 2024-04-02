---
title: New-EntraMSApplicationExtensionProperty
description: This article provides details on the New-EntraMSApplicationExtensionProperty command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSApplicationExtensionProperty

## SYNOPSIS
Creates an extension property on an application object.

## SYNTAX

```powershell
New-EntraMSApplicationExtensionProperty 
    -ObjectId <String> 
    [-DataType <String>] 
    [-TargetObjects <System.Collections.Generic.List`1[System.String]>] 
    [-Name <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
Creates an extension property on an application object.

## EXAMPLES

### Example 1: Create an extension property
```powershell
PS C:\>New-EntraMSApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -DataType "string" -Name "NewAttribute" -TargetObjects "Application"
```

```output
ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command creates an application extension property of the string type for the specified object.

## PARAMETERS

### -DataType
Specifies the data type of the extension property.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the data type of the extension property.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

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

### -TargetObjects
Specifies target objects.

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

### String
### System.Collections.Generic.List`1[System.String]
## OUTPUTS

### Microsoft.Open.MSGraph.Model.ExtensionProperty
## NOTES

## RELATED LINKS

[Get-EntraMSApplicationExtensionProperty](Get-EntraMSApplicationExtensionProperty.md)

[Remove-EntraMSApplicationExtensionProperty](Remove-EntraMSApplicationExtensionProperty.md)

