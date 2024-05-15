---
title: Set-EntraMSPermissionGrantPolicy
description: This article provides details on the Set-EntraMSPermissionGrantPolicy command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSPermissionGrantPolicy

## SYNOPSIS
Updates a permission grant policy.

## SYNTAX

```powershell
Set-EntraMSPermissionGrantPolicy 
 -Id <String>
 [-DisplayName <String>] 
 [-Description <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSPermissionGrantPolicy command updates a Microsoft Entra ID permission grant policy.

## EXAMPLES

### Example 1: Update description of permission grant policy
```powershell
PS C:\> Set-EntraMSPermissionGrantPolicy -Id "my_permission_grant_policy_id" -Description "updated description"
```

This command updates the description of the specified permission grant policy.

### Example 2: Update display name of permission grant policy
```powershell
PS C:\> Set-EntraMSPermissionGrantPolicy -Id "my_permission_grant_policy_id" -DisplayName "update displayname"
```

This command updates the display name of the specified permission grant policy.

## PARAMETERS

### -Description
Specifies the description of the permission grant policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name of the permission grant policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the unique identifier of the permission grant policy.

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

[New-EntraMSPermissionGrantPolicy](New-EntraMSPermissionGrantPolicy.md)

[Get-EntraMSPermissionGrantPolicy](Get-EntraMSPermissionGrantPolicy.md)

[Remove-EntraMSPermissionGrantPolicy](Remove-EntraMSPermissionGrantPolicy.md)

