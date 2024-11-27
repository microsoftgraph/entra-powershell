---
title: Add-EntraServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Add-EntraServicePrincipalDelegatedPermissionClassification command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraServicePrincipalDelegatedPermissionClassification

schema: 2.0.0
---

# Add-EntraServicePrincipalDelegatedPermissionClassification

## Synopsis

Add a classification for a delegated permission.

## Syntax

```powershell
Add-EntraServicePrincipalDelegatedPermissionClassification
 -ServicePrincipalId <String>
 -PermissionId <String>
 -Classification <ClassificationEnum>
 -PermissionName <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraServicePrincipalDelegatedPermissionClassification` cmdlet creates a delegated permission classification for the given permission on service principal.

## Examples

### Example 1: Create Delegated Permission Classification

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
$PermissionId = $ServicePrincipal.PublishedPermissionScopes[0].Id
$PermissionName =  $ServicePrincipal.PublishedPermissionScopes[0].Value

$params = @{
    ServicePrincipalId = $ServicePrincipal.ObjectId
    PermissionId = $PermissionId
    Classification = 'Low'
    PermissionName = $PermissionName
}

Add-EntraServicePrincipalDelegatedPermissionClassification @params
```

```Output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
T2qU_E28O0GgkLLIYRPsTwE low            fc946a4f-bc4d-413b-a090-b2c86113ec4f LicenseManager.AccessAsUser
```

This command creates a delegated permission classification for the given permission on the service principal. You can use the command `Get-EntraServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.
- `-PermissionId` parameter specifies the ID for a delegated permission.
- `-Classification` parameter specifies the classification for a delegated permission.
- `-PermissionName` parameter specifies the name for a delegated permission.

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

### -PermissionId

The ID for a delegated permission.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionName

The name for a delegated permission.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Classification

The classification for a delegated permission.
This parameter can take one of the following values:

- Low: Specifies a classification for a permission as low impact.

- Medium: Specifies a classification for a permission as medium impact.

- High: Specifies a classification for a permission as high impact.

```yaml
Type: ClassificationEnum
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.DelegatedPermissionClassification

## Notes

## Related Links

[Get-EntraServicePrincipalDelegatedPermissionClassification](Get-EntraServicePrincipalDelegatedPermissionClassification.md)

[Remove-EntraServicePrincipalDelegatedPermissionClassification](Remove-EntraServicePrincipalDelegatedPermissionClassification.md)
