---
title: Remove-EntraServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Remove-EntraServicePrincipalDelegatedPermissionClassification command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipalDelegatedPermissionClassification

schema: 2.0.0
---

# Remove-EntraServicePrincipalDelegatedPermissionClassification

## Synopsis

Remove delegated permission classification.

## Syntax

```powershell
Remove-EntraServicePrincipalDelegatedPermissionClassification
 -ServicePrincipalId <String>
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraServicePrincipalDelegatedPermissionClassification` cmdlet deletes the given delegated permission classification by Id from service principal.

## Examples

### Example 1: Remove a delegated permission classification

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
$params = @{
    ServicePrincipalId = $ServicePrincipal.ObjectId
    Id = 'aaaa0000-bb11-2222-33cc-444444dddddd'
}
Remove-EntraServicePrincipalDelegatedPermissionClassification @params
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

## Related Links

[Get-EntraServicePrincipalDelegatedPermissionClassification](Get-EntraServicePrincipalDelegatedPermissionClassification.md)

[Add-EntraServicePrincipalDelegatedPermissionClassification](Add-EntraServicePrincipalDelegatedPermissionClassification.md)
