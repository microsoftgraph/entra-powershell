---
title: Remove-EntraBetaServicePrincipalPolicy
description: This article provides details on the Remove-EntraBetaServicePrincipalPolicy command.


ms.topic: reference
ms.date: 07/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaServicePrincipalPolicy

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalPolicy

## Synopsis

Delete a servicePrincipal policy.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalPolicy
 -Id <String>
 -PolicyId <String>
 [<CommonParameters>]
```

## Description

Delete a servicePrincipal policy. Specify the `Id` and `PolicyId` parameter to remove a specific servicePrincipal policy.

## Examples

### Example 1: Remove a service principal policy

```powershell
Connect-Entra -Scopes Policy.Read.All, Application.ReadWrite.All
$params = @{
    Id = 'bbbbbbbb-1111-1111-1111-cccccccccccc'
    PolicyId = 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
}
Remove-EntraBetaServicePrincipalPolicy @params
```

This command removes a specific servicePrincipal policy in Microsoft Entra ID.

## Parameters

### -PolicyId

Specifies the object ID of a policy.

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

Specifies the object Id of the Service Principal.

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

[Add-EntraBetaServicePrincipalPolicy](Add-EntraBetaServicePrincipalPolicy.md)

[Get-EntraBetaServicePrincipalPolicy](Get-EntraBetaServicePrincipalPolicy.md)
