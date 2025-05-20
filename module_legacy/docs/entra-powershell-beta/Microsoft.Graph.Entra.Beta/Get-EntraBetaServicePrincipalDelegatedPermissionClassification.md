---
title: Get-EntraBetaServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Get-EntraBetaServicePrincipalDelegatedPermissionClassification command.


ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalDelegatedPermissionClassification

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalDelegatedPermissionClassification

## Synopsis

Retrieve the delegated permission classification objects on a service principal.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaServicePrincipalDelegatedPermissionClassification
 -ServicePrincipalId <String>
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaServicePrincipalDelegatedPermissionClassification
 -ServicePrincipalId <String>
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalDelegatedPermissionClassification` cmdlet retrieves the delegated permission classifications from a service principal.

## Examples

### Example 1: Get a list of delegated permission classifications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
$params = @{
  ServicePrincipalId = $servicePrincipal.ObjectId
}
Get-EntraBetaServicePrincipalDelegatedPermissionClassification @params
```

```Output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
cccccccc-8888-9999-0000-dddddddddddd low            dddd3333-ee44-5555-66ff-777777aaaaaa profile
```

This command retrieves all delegated permission classifications from the service principal.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal. Use `Get-EntraBetaServicePrincipal` to get more details.

### Example 2: Get a delegated permission classifications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
$params = @{
  ServicePrincipalId = $servicePrincipal.ObjectId 
  Id = '5XBeIKarUkypdm0tRsSAQwE'
}
Get-EntraBetaServicePrincipalDelegatedPermissionClassification @params
```

```Output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command retrieves the delegated permission classification by Id from the service principal.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal. Use `Get-EntraBetaServicePrincipal` to get more details.
- `-Id` parameter specifies the delegated permission classification object Id.

### Example 3: Get a delegated permission classification with filter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
$params = @{
  ServicePrincipalId = $servicePrincipal.ObjectId  
  Filter = "PermissionName eq 'Sites.Read.All'"
}
Get-EntraBetaServicePrincipalDelegatedPermissionClassification @params
```

```Output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command retrieves the filtered delegated permission classifications from the service principal.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal. Use `Get-EntraBetaServicePrincipal` to get more details.
- `-Id` parameter specifies the delegated permission classification object Id.

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

The unique identifier of a delegated permission classification object ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The OData v4.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
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

## Related links

[Add-EntraBetaServicePrincipalDelegatedPermissionClassification](Add-EntraBetaServicePrincipalDelegatedPermissionClassification.md)

[Remove-EntraBetaServicePrincipalDelegatedPermissionClassification](Remove-EntraBetaServicePrincipalDelegatedPermissionClassification.md)
