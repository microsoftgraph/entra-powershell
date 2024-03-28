---
title: Remove-EntraOAuth2PermissionGrant 
description: This article provides details on the Remove-EntraOAuth2PermissionGrant command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraOAuth2PermissionGrant

## SYNOPSIS
Removes an oAuth2PermissionGrant.

## SYNTAX

```
Remove-EntraOAuth2PermissionGrant 
-ObjectId <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraOAuth2PermissionGrant cmdlet removes an oAuth2PermissionGrant object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an OAuth2 permission grant

```powershell
PS C:\> $SharePointSP = Get-EntraServicePrincipal | Where-Object {$_.DisplayName -eq "Microsoft.SharePoint"}
PS C:\> $SharePointOA2AllSitesRead = Get-EntraOAuth2PermissionGrant | Where-Object {$_.ResourceId -eq $SharePointSP.ObjectId} | Where-Object {$_.Scope -eq "AllSites.Read"}
PS C:\> Remove-EntraOAuth2PermissionGrant -ObjectId $SharePointOA2AllSitesRead.ObjectId
```

The first command gets a service principal that matches the specified display name by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the result in the $SharePointSP variable.

The second command gets certain permission grants by using the Get-EntraOAuth2PermissionGrant (./Get-EntraOAuth2PermissionGrant.md) cmdlet. 
The command stores the result in the $SharePointOA2AllSitesRead variable.

The final command removes the permission grant in $SharePointOA2AllSitesRead.

## PARAMETERS

### -ObjectId
Specifies the ID of an oAuth2PermissionGrant object in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraOAuth2PermissionGrant](Get-EntraOAuth2PermissionGrant.md)

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)