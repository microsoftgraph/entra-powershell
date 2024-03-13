---
title: Get-EntraMSServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Get-EntraMSServicePrincipalDelegatedPermissionClassification command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/13/2024
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
The **Get-EntraMSServicePrincipalDelegatedPermissionClassification** cmdlet retrieves the delegated permission classifications from a service principal.

## EXAMPLES

### Example 1: Get a list of delegated permission classifications
```powershell
PS C:\> Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "95f56359-0165-4f80-bffb-c89d06cf2c6f"
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
5XBeIKarUkypdm0tRsSAQwE low            205e70e5-aba6-4c52-a976-6d2d46c48043 Sites.Read.All
ntbaFJsJyUKBC9ACmB_uwQE low            14dad69e-099b-42c9-810b-d002981feec1 profile
```

This command retrieves all delegated permission classifications from the service principal.

### Example 2: Get a delegated permission classification
```powershell
PS C:\> Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "95f56359-0165-4f80-bffb-c89d06cf2c6f" -Id "5XBeIKarUkypdm0tRsSAQwE"
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
5XBeIKarUkypdm0tRsSAQwE low            205e70e5-aba6-4c52-a976-6d2d46c48043 Sites.Read.All
```

This command retrieves the delegated permission classification by Id from the service principal.

### Example 3: Get a delegated permission classification with filter
```powershell
PS C:\> Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "95f56359-0165-4f80-bffb-c89d06cf2c6f" -Filter "PermissionName eq 'Sites.Read.All'"
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
5XBeIKarUkypdm0tRsSAQwE low            205e70e5-aba6-4c52-a976-6d2d46c48043 Sites.Read.All
```

This command retrieves the filtered delegated permission classifications from the service principal.

## PARAMETERS

### -ServicePrincipalId
The unique identifier of a service principal object in Microsoft Entra ID.

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

### -Id
The unique identifier of a delegated permission classification object id.

```yaml
Type: String
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
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.DelegatedPermissionClassification
## NOTES
## RELATED LINKS
