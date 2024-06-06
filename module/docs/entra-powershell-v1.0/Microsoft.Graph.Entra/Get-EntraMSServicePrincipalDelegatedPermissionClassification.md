---
title: Get-EntraMSServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Get-EntraMSServicePrincipalDelegatedPermissionClassification command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSServicePrincipalDelegatedPermissionClassification

## SYNOPSIS

Retrieve the delegated permission classification objects on a service principal.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraMSServicePrincipalDelegatedPermissionClassification 
 -ServicePrincipalId <String> 
 [-Filter <String>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSServicePrincipalDelegatedPermissionClassification 
 -ServicePrincipalId <String> 
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraMSServicePrincipalDelegatedPermissionClassification cmdlet retrieves the delegated permission classifications from a service principal.

## EXAMPLES

### Example 1: Get a list of delegated permission classifications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 'bbbb1111-cc22-3333-44dd-555555eeeeee'
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
cccccccc-8888-9999-0000-dddddddddddd low            dddd3333-ee44-5555-66ff-777777aaaaaa profile
```

This command retrieves all delegated permission classifications from the service principal.

### Example 2: Get a delegated permission classification

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 'bbbb1111-cc22-3333-44dd-555555eeeeee' -Id 'bbbbbbbb-7777-8888-9999-cccccccccccc'
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command retrieves the delegated permission classification by Id from the service principal.

### Example 3: Get a delegated permission classification with filter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 'bbbb1111-cc22-3333-44dd-555555eeeeee -Filter "PermissionName eq 'Sites.Read.All'"
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbbbbbb-7777-8888-9999-cccccccccccc low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command retrieves the filtered delegated permission classifications from the service principal.

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

### -Id

The unique identifier of a delegated permission classification object id.

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

The oData v3.0 filter statement.
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.DelegatedPermissionClassification

## NOTES

## RELATED LINKS

- [Remove-EntraMSServicePrincipalDelegatedPermissionClassification](Remove-EntraMSServicePrincipalDelegatedPermissionClassification.md)

- [Add-EntraMSServicePrincipalDelegatedPermissionClassification](Add-EntraMSServicePrincipalDelegatedPermissionClassification.md)
