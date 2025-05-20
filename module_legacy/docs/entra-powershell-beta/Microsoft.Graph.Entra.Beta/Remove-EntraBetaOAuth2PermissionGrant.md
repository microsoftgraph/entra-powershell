---
title: Remove-EntraBetaOAuth2PermissionGrant 
description: This article provides details on the Remove-EntraBetaOAuth2PermissionGrant command.


ms.topic: reference
ms.date: 08/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaOAuth2PermissionGrant

schema: 2.0.0
---

# Remove-EntraBetaOAuth2PermissionGrant

## Synopsis

Removes an OAuth2PermissionGrant.

## Syntax

```powershell
Remove-EntraBetaOAuth2PermissionGrant
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaOAuth2PermissionGrant` cmdlet removes an OAuth2PermissionGrant object in Microsoft Entra ID.

When a delegated permission grant is deleted, the access it granted is revoked. Existing access tokens will continue to be valid for their lifetime, but new access tokens will not be granted for the delegated permissions identified in the deleted OAuth2PermissionGrant.

## Examples

### Example 1: Remove an OAuth2 permission grant

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$SharePointSP = Get-EntraBetaServicePrincipal | Where-Object {$_.DisplayName -eq 'Microsoft.SharePoint'}
$SharePointOA2AllSitesRead = Get-EntraBetaOAuth2PermissionGrant | Where-Object {$_.ResourceId -eq $SharePointSP.ObjectId} | Where-Object {$_.Scope -eq 'AllSites.Read'}
Remove-EntraBetaOAuth2PermissionGrant -ObjectId $SharePointOA2AllSitesRead.ObjectId
```

This example shows how to remove an OAuth2PermissionGrant object in Microsoft Entra ID.

## Parameters

### -ObjectId

Specifies the ID of an OAuth2PermissionGrant object in Microsoft Entra ID.

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

[Get-EntraBetaOAuth2PermissionGrant](Get-EntraBetaOAuth2PermissionGrant.md)

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)
