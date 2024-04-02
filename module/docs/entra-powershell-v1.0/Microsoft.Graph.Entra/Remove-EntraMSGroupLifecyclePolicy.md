---
title: Remove-EntraMSGroupLifecyclePolicy
description: This article provides details on the Remove-EntraMSGroupLifecyclePolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSGroupLifecyclePolicy

## SYNOPSIS
Deletes a groupLifecyclePolicies object

## SYNTAX

```
Remove-EntraMSGroupLifecyclePolicy 
-Id <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraMSGroupLifecyclePolicy command deletes a groupLifecyclePolicies object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a groupLifecyclePolicies.

```powershell
PS C:\> Remove-EntraMSGroupLifecyclePolicy -Id "13bed58e-6144-41e5-abbd-47c95964e671"
```

This cmdlet deletes the groupLifecyclePolicies object that has the specified ID.

## PARAMETERS

### -Id
Specifies the ID of the groupLifecyclePolicies object that this cmdlet removes.

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

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Get-EntraMSGroupLifecyclePolicy](Get-EntraMSGroupLifecyclePolicy.md)

[New-EntraMSGroupLifecyclePolicy](New-EntraMSGroupLifecyclePolicy.md)

[Set-EntraMSGroupLifecyclePolicy](Set-EntraMSGroupLifecyclePolicy.md)
