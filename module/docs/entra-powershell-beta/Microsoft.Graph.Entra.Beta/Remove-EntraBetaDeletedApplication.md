---
Title: Remove-EntraBetaDeletedApplication
Description: This article provides details on the Remove-EntraBetaDeletedApplication command.
Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Remove-EntraBetaDeletedApplication

## Synopsis
Permanently delete a recently deleted application object from deleted items.

## Syntax

```powershell
Remove-EntraBetaDeletedApplication 
 [-ObjectId] <String> 
[<CommonParameters>]
```

## Description
Permanently delete a recently deleted application object from deleted items. After an item is permanently deleted, it can't be restored.
## Examples

### Example 1: Remove deleted application object
```powershell
PS C:\> $Id = Get-EntraBetaDeletedApplication -SearchString "newtest10" 
PS C:\> Remove-EntraBetaDeletedApplication -ObjectId $Id.id
```

This command removes recently deleted application.

## Parameters

### -ObjectId
The unique identifier of deleted application.
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object
## Notes

## Related Links
