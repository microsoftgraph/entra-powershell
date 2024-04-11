---
title: Remove-EntraMSServicePrincipalDelegatedPermissionClassification.
description: This article provides details on the Remove-EntraMSServicePrincipalDelegatedPermissionClassification command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSServicePrincipalDelegatedPermissionClassification

## SYNOPSIS
Remove delegated permission classification.

## SYNTAX

```powershell
Remove-EntraMSServicePrincipalDelegatedPermissionClassification 
 -ServicePrincipalId <String>
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraMSServicePrincipalDelegatedPermissionClassification cmdlet deletes the given delegated permission classification by ID from service principal.

## EXAMPLES

### Example 1: Remove a delegated permission classification
```powershell
PS C:\> Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "95f56359-0165-4f80-bffb-c89d06cf2c6f" -Id "5XBeIKarUkypdm0tRsSAQwE"
```

This command deletes the delegated permission classification by ID from the service principal.

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
The unique identifier of a delegated permission classification object ID.

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
