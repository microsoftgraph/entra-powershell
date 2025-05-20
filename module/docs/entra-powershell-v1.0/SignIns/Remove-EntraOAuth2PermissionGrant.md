---
title: Remove-EntraOAuth2PermissionGrant 
description: This article provides details on the Remove-EntraOAuth2PermissionGrant command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.SignIns-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraOAuth2PermissionGrant

schema: 2.0.0
---

# Remove-EntraOAuth2PermissionGrant

## Synopsis

Removes an OAuth2PermissionGrant.

## Syntax

```powershell
Remove-EntraOAuth2PermissionGrant
 -OAuth2PermissionGrantId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraOAuth2PermissionGrant` cmdlet removes an OAuth2PermissionGrant object in Microsoft Entra ID.

When a delegated permission grant is deleted, the access it granted is revoked. Existing access tokens will continue to be valid for their lifetime, but new access tokens will not be granted for the delegated permissions identified in the deleted OAuth2PermissionGrant.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Application Developer  
- Cloud Application Administrator  
- Directory Writers  
- User Administrator  
- Privileged Role Administrator

## Examples

### Example 1: Remove an OAuth2 permission grant

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$sharePointSP = Get-EntraServicePrincipal | Where-Object { $_.DisplayName -eq 'Microsoft.SharePoint' }
$sharePointOAuth2AllSitesRead = Get-EntraOAuth2PermissionGrant | Where-Object { $_.ResourceId -eq $sharePointSP.Id } | Where-Object { $_.Scope -eq 'AllSites.Read' }
Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId $sharePointOAuth2AllSitesRead.Id
```

This example shows how to remove an OAuth2PermissionGrant object in Microsoft Entra ID.

## Parameters

### -OAuth2PermissionGrantId

Specifies the ID of an OAuth2PermissionGrant object in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraOAuth2PermissionGrant](Get-EntraOAuth2PermissionGrant.md)

[Get-EntraServicePrincipal](../Applications/Get-EntraServicePrincipal.md)

[Update-EntraOAuth2PermissionGrant](Update-EntraOauth2PermissionGrant.md)
