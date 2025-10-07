---
description: This article provides details on the Remove-EntraBetaOAuth2PermissionGrant command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.SignIns
ms.author: eunicewaweru
ms.date: 08/09/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.SignIns/Remove-EntraBetaOAuth2PermissionGrant
schema: 2.0.0
title: Remove-EntraBetaOAuth2PermissionGrant
---

# Remove-EntraBetaOAuth2PermissionGrant

## SYNOPSIS

Removes an OAuth2PermissionGrant.

## SYNTAX

```powershell
Remove-EntraBetaOAuth2PermissionGrant
 -OAuth2PermissionGrantId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaOAuth2PermissionGrant` cmdlet removes an OAuth2PermissionGrant object in Microsoft Entra ID.

When a delegated permission grant is deleted, the access it granted is revoked. Existing access tokens will continue to be valid for their lifetime, but new access tokens will not be granted for the delegated permissions identified in the deleted OAuth2PermissionGrant.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Application Developer  
- Cloud Application Administrator  
- Directory Writers  
- User Administrator  
- Privileged Role Administrator

## EXAMPLES

### Example 1: Remove an OAuth2 permission grant

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$sharePointSP = Get-EntraBetaServicePrincipal | Where-Object { $_.DisplayName -eq 'Microsoft.SharePoint' }
$sharePointOAuth2AllSitesRead = Get-EntraBetaOAuth2PermissionGrant | Where-Object { $_.ResourceId -eq $sharePointSP.Id } | Where-Object { $_.Scope -eq 'AllSites.Read' }
Remove-EntraBetaOAuth2PermissionGrant -OAuth2PermissionGrantId $sharePointOAuth2AllSitesRead.Id
```

This example shows how to remove an OAuth2PermissionGrant object in Microsoft Entra ID.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaOAuth2PermissionGrant](Get-EntraBetaOAuth2PermissionGrant.md)

[Get-EntraBetaServicePrincipal](../Applications/Get-EntraBetaServicePrincipal.md)
