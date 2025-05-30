---
title: Remove-EntraBetaServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Remove-EntraBetaServicePrincipalDelegatedPermissionClassification command.


ms.topic: reference
ms.date: 08/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaServicePrincipalDelegatedPermissionClassification

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalDelegatedPermissionClassification

## Synopsis

Remove delegated permission classification.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalDelegatedPermissionClassification
 -ServicePrincipalId <String>
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipalDelegatedPermissionClassification` cmdlet deletes the given delegated permission classification by Id from service principal.

## Examples

### Example 1: Remove a delegated permission classification

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$permissionClassification = Get-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id | Where-Object {$_.PermissionName -eq 'Sites.Read.All'}
Remove-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id -Id $permissionClassification.Id
```

This command deletes the delegated permission classification by Id from the service principal.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.
- `-Id` parameter specifies the unique identifier of a delegated permission classification object Id.

## Parameters

### -ServicePrincipalId

The unique identifier of a service principal object in Microsoft Entra ID.

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

The unique identifier of a delegated permission classification object Id.

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

[Add-EntraBetaServicePrincipalDelegatedPermissionClassification](Add-EntraBetaServicePrincipalDelegatedPermissionClassification.md)

[Get-EntraBetaServicePrincipalDelegatedPermissionClassification](Get-EntraBetaServicePrincipalDelegatedPermissionClassification.md)
