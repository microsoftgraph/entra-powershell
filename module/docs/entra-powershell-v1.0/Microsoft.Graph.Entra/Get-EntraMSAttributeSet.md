---
title: Get-EntraMSAttributeSet
description: This article provides details on the Get-EntraMSAttributeSet command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSAttributeSet

## SYNOPSIS
Gets a list of attribute sets.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraMSAttributeSet
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraMSAttributeSett 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
Gets a list of Microsoft Entra ID attribute sets.

## EXAMPLES

### Example 1: Get an all attribute sets.
```powershell
Get-EntraMSAttributeSet
```
```output
description                           id                    maxAttributesPerSet
-----------                           --                    -------------------
Attributes for cloud engineering team engineering                            25
Attributes for test2  team            Test2                                  25
NEW Demo Description                  demo                                   25
TEST THE DEMO                         demo2
                                      DEMO5
Description to test the demo6         DEMO6
Description to test the demo6         DEMO7                                  24
```
This example Get all attribute sets.

### Example 2: Get an attribute sets.
```powershell
Get-EntraMSAttributeSet -Id "Engineering"
```
```output
description                           id                    maxAttributesPerSet
-----------                           --                    -------------------
Attributes for cloud engineering team Engineering                            25
```

This example gets an attribute set.

- Attribute set: `Engineering`

## PARAMETERS

### -Id
The unique identifier of a Microsoft Entra ID set object.

```yaml
Type: String
Parameter Sets: GetById
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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
