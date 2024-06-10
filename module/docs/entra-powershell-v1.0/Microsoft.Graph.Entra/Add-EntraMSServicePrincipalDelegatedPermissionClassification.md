---
title: Add-EntraMSServicePrincipalDelegatedPermissionClassification
description: This article provides details on the Add-EntraMSServicePrincipalDelegatedPermissionClassification command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
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
$ServicePrincipal = Get-EntraServicePrincipal -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444'
$PermissionId = $ServicePrincipal.Oauth2PermissionScopes[0].Id
$PermissionName =  $ServicePrincipal.Oauth2PermissionScopes[0].Value

$params = @{
    ServicePrincipalId = $ServicePrincipal.Id
    PermissionId = $PermissionId
    Classification = 'Low'
    PermissionName = $PermissionName
}

Add-EntraMSServicePrincipalDelegatedPermissionClassification @params
```

```output
Id                      Classification PermissionId                         PermissionName
--                      -------------- ------------                         --------------
bbbb1111-cc22-3333-44dd-555555eeeeee low            eeeeeeee-4444-5555-6666-ffffffffffff Sites.Read.All
```

This command creates a delegated permission classification for the given permission on the service principal.

- The first command get the specified service principal using [Get-EntraServicePrincipal](Get-EntraServicePrincipal.md) cmdlet and stores it in $ServicePrincipal.
- The second command gets the Id from first item in Oauth2PermissionScopes list from the retrieved service principal.
- The third command gets the value from first item in Oauth2PermissionScopes list from the retrieved service principal.  

## PARAMETERS

### -ServicePrincipalId

The unique identifier of a service principal object in Microsoft Entra ID.

```yaml
Type: System.tring
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

"Low": Specifies a classification for a permission as low impact.
"Medium": Specifies a classification for a permission as medium impact.
"High": Specifies a classification for a permission as high impact.

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

[Get-EntraMSServicePrincipalDelegatedPermissionClassification](Get-EntraMSServicePrincipalDelegatedPermissionClassification.md)

[Remove-EntraMSServicePrincipalDelegatedPermissionClassification](Remove-EntraMSServicePrincipalDelegatedPermissionClassification.md)
