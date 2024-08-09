---
title: Remove-EntraApplicationPolicy.
description: This article provides details on the Remove-EntraApplicationPolicy command.
ms.service: active-directory
ms.topic: reference
ms.date: 06/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraScopedRoleMembership

schema: 2.0.0
---

# Remove-EntraApplicationPolicy

## Synopsis

Removes an application policy.

## Syntax

```powershell
Remove-EntraApplicationPolicy 
 -Id <String> 
 -PolicyId <String> 
 [<CommonParameters>]
```

## Description

The `Remove-EntraApplicationPolicy` cmdlet removes an application policy from Microsoft Entra ID. Specify the `Id` and `PolicyId` parameter to remove an application policy.

## Examples

### Example 1: Remove an application policy

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    PolicyId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Remove-EntraApplicationPolicy @params
```

This command removes the specified application policy.

## Parameters

### -PolicyId

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

Specifies the ID of Policy.

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

## Related Links

[Add-EntraApplicationPolicy](Add-EntraApplicationPolicy.md)

[Get-EntraApplicationPolicy](Get-EntraApplicationPolicy.md)
