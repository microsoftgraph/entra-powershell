---
title: New-EntraMSPermissionGrantPolicy
description: This article provides details on the New-EntraMSPermissionGrantPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSPermissionGrantPolicy

## SYNOPSIS
Creates a permission grant policy.

## SYNTAX

```powershell
New-EntraMSPermissionGrantPolicy 
 -Id <String>
 [-DisplayName <String>] 
 [-Description <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraMSPermissionGrantPolicy cmdlet creates a Microsoft Entra ID permission grant policy.

## EXAMPLES

### Example 1: Create a permission grant policy
```powershell
PS C:\> New-EntraMSPermissionGrantPolicy -Id "my_new_permission_grant_policy_id"
```

```output
DeletedDateTime Description DisplayName Id
--------------- ----------- ----------- --
                                        my_new_permission_grant_policy_id
```

This command creates new permission grant policy.

### Example 1: Create a permission grant policy with display name and description parameters
```powershell
PS C:\> New-EntraMSPermissionGrantPolicy -Id "my_new_permission_grant_policy_id"  -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy"
```

```output
DeletedDateTime Description                    DisplayName                Id
--------------- -----------                    -----------                --
                My new permission grant policy MyNewPermissionGrantPolicy my_new_permission_grant_policy_id
```

This command creates new permission grant policy.

## PARAMETERS

### -Description
Specifies the description for the permission grant policy.

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
Specifies the display name for the permission grant policy.

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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSPermissionGrantPolicy](Get-EntraMSPermissionGrantPolicy.md)

[Set-EntraMSPermissionGrantPolicy](Set-EntraMSPermissionGrantPolicy.md)

[Remove-EntraMSPermissionGrantPolicy](Remove-EntraMSPermissionGrantPolicy.md)

