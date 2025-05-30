---
title: Add-EntraBetaServicePrincipalPolicy
description: This article provides details on the Add-EntraBetaServicePrincipalPolicy command.


ms.topic: reference
ms.date: 07/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaServicePrincipalPolicy

schema: 2.0.0
---

# Add-EntraBetaServicePrincipalPolicy

## Synopsis

Adds a servicePrincipal policy.

## Syntax

```powershell
Add-EntraBetaServicePrincipalPolicy
 -Id <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaServicePrincipalPolicy` cmdlet adds a service principal policy. Specify the `Id` and `PolicyId` parameter to add a specific servicePrincipal policy.

## Examples

### Example 1: Add a service principal policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All, Application.ReadWrite.All'
$params = @{
    Id = 'bbbbbbbb-1111-1111-1111-cccccccccccc'
    RefObjectId = 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
}
Add-EntraBetaServicePrincipalPolicy @params
```

This example demonstrates how to add a policy to a service principal in Microsoft Entra ID.

## Parameters

### -RefObjectId

Specifies the object Id of the policy.

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

The ID of the Service Principal for which you need to set the policy

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

[Get-EntraBetaServicePrincipalPolicy](Get-EntraBetaServicePrincipalPolicy.md)

[Remove-EntraBetaServicePrincipalPolicy](Remove-EntraBetaServicePrincipalPolicy.md)
