---
title: Remove-EntraBetaServicePrincipalOwner
description: This article provides details on the Remove-EntraBetaServicePrincipalOwner command.

ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalOwner

## Synopsis

Removes an owner from a service principal.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalOwner
 -OwnerId <String>
 -ServicePrincipalId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipalOwner` cmdlet removes an owner from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Removes an owner from a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$ownership = Get-EntraBetaServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
$owner = $ownership | Where-Object {$_.userPrincipalName -eq 'SawyerM@Contoso.com' }
Remove-EntraBetaServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -OwnerId $owner.Id
```

This example demonstrates how to remove an owner from a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the service principal Id.
- `-OwnerId` parameter specifies the service principal owner Id.

## Parameters

### -ServicePrincipalId

Specifies the ID of a service principal.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OwnerId

Specifies the ID of the owner.

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

[Add-EntraBetaServicePrincipalOwner](Add-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaServicePrincipalOwner](Get-EntraBetaServicePrincipalOwner.md)
