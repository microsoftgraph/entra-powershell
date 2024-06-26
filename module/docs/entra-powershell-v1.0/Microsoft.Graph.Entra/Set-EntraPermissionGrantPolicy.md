---
title: Set-EntraPermissionGrantPolicy
description: This article provides details on the Set-EntraPermissionGrantPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraPermissionGrantPolicy

## Synopsis
updates a permission grant policy.

## Syntax

```powershell
Set-EntraPermissionGrantPolicy 
 -Id <String>
 [-DisplayName <String>] 
 [-Description <String>] 
 [<CommonParameters>]
```

## Description
the Set-EntraPermissionGrantPolicy command updates a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Update description of permission grant policy
```powershell
PS C:\> Set-EntraPermissionGrantPolicy -Id "my_permission_grant_policy_id" -Description "updated description"
```

This command updates the description of the specified permission grant policy.

### Example 2: Update display name of permission grant policy
```powershell
PS C:\> Set-EntraPermissionGrantPolicy -Id "my_permission_grant_policy_id" -DisplayName "update displayname"
```

This command updates the display name of the specified permission grant policy.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraPermissionGrantPolicy](New-EntraPermissionGrantPolicy.md)

[Get-EntraPermissionGrantPolicy](Get-EntraPermissionGrantPolicy.md)

[Remove-EntraPermissionGrantPolicy](Remove-EntraPermissionGrantPolicy.md)

