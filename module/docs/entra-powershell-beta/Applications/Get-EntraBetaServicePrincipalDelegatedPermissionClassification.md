---
author: msewaweru
description: This article provides details on the Get-EntraBetaServicePrincipalDelegatedPermissionClassification command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/29/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaServicePrincipalDelegatedPermissionClassification
schema: 2.0.0
title: Get-EntraBetaServicePrincipalDelegatedPermissionClassification
---

# Get-EntraBetaServicePrincipalDelegatedPermissionClassification

## SYNOPSIS

Retrieve the delegated permission classification objects on a service principal.

## SYNTAX

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

## DESCRIPTION

The `Get-EntraBetaServicePrincipalDelegatedPermissionClassification` cmdlet retrieves the delegated permission classifications from a service principal.

## EXAMPLES

### Example 1: Get a list of delegated permission classifications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id
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
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$permissionClassification = Get-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id -Filter "PermissionName eq 'Sites.Read.All'"
Get-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id -Id $permissionClassification.Id
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
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalDelegatedPermissionClassification -ServicePrincipalId $servicePrincipal.Id -Filter "PermissionName eq 'Sites.Read.All'"
```

```Output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command retrieves the filtered delegated permission classifications from the service principal.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal. Use `Get-EntraBetaServicePrincipal` to get more details.
- `-Id` parameter specifies the delegated permission classification object Id.

## PARAMETERS

### -ServicePrincipalId

The unique identifier of a service principal object in Microsoft Entra ID.

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
Aliases: Select

Required: False
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

[Add-EntraBetaServicePrincipalDelegatedPermissionClassification](Add-EntraBetaServicePrincipalDelegatedPermissionClassification.md)

[Remove-EntraBetaServicePrincipalDelegatedPermissionClassification](Remove-EntraBetaServicePrincipalDelegatedPermissionClassification.md)
