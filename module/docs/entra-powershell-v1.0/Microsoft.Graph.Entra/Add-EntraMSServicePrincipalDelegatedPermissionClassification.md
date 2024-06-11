---
title: Add-EntraMSServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Add-EntraMSServicePrincipalDelegatedPermissionClassification command.

ms.service: entra
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSServicePrincipalDelegatedPermissionClassification

## SYNOPSIS

Add a classification for a delegated permission.

## SYNTAX

```powershell
Add-EntraMSServicePrincipalDelegatedPermissionClassification 
 -ServicePrincipalId <String> 
 -PermissionId <String>
 -Classification <ClassificationEnum> 
 -PermissionName <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraMSServicePrincipalDelegatedPermissionClassification cmdlet creates a delegated permission classification for the given permission on service principal.

## EXAMPLES

### Example 1: Create Delegated Permission Classification

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$ServicePrincipal = Get-EntraServicePrincipal -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
$PermissionId = $ServicePrincipal.Oauth2PermissionScopes[0].Id
$PermissionName =  $ServicePrincipal.Oauth2PermissionScopes[0].Value
Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $ServicePrincipal.Id -PermissionId $PermissionId -Classification Low -PermissionName $PermissionName
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
eszf101IRka9VZoGVVnbBgE low            205e70e5-aba6-4c52-a976-6d2d46c48043 Sites.Read.All
```

- The first command connects to the tenant with the right scopes to run the example.

- The second command get the specified service principal using [Get-EntraServicePrincipal](Get-EntraServicePrincipal.md) cmdlet and stores it in $ServicePrincipal.  

- The third command gets the Id from first item in Oauth2PermissionScopes list from the retrieved service principal.  

- The forth command gets the value from first item in Oauth2PermissionScopes list from the retrieved service principal.  

- Lastly we create a delegated permission classification for the given permission on the service principal.

## PARAMETERS

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

The id for a delegated permission.

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

* "Low" - Specifies a classification for a permission as low impact.
* "Medium" - Specifies a classification for a permission as medium impact.
* "High" - Specifies a classification for a permission as high impact.

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

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.DelegatedPermissionClassification

## NOTES

## RELATED LINKS
