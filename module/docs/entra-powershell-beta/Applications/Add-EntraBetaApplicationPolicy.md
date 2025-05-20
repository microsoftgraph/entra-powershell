---
title: Add-EntraBetaApplicationPolicy
description: This article provides details on the Add-EntraBetaApplicationPolicy command.


ms.topic: reference
ms.date: 07/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaApplicationPolicy

schema: 2.0.0
---

# Add-EntraBetaApplicationPolicy

## Synopsis

Adds an application policy.

## Syntax

### ByApplicationIdAndPolicyId

```powershell
Add-EntraBetaApplicationPolicy
 -Id <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaApplicationPolicy` cmdlet adds a Microsoft Entra ID application policy. Specify `Id` and `RefObjectId` parameters to add an application policy.

## Examples

### Example 1: Add an application policy

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All, Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    RefObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Add-EntraBetaApplicationPolicy @params
```

This example demonstrates how to add an application policy.

## Parameters

### -RefObjectId

Specifies the ID of the policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id

The ID of the application for which you need to set the policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaApplicationPolicy](Get-EntraBetaApplicationPolicy.md)

[Remove-EntraBetaApplicationPolicy](Remove-EntraBetaApplicationPolicy.md)
