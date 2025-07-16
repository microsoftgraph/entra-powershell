---
author: msewaweru
description: This article provides details on Get-EntraBetaPrivilegedRoleSetting command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/12/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaPrivilegedRoleSetting
schema: 2.0.0
title: Get-EntraBetaPrivilegedRoleSetting
---

# Get-EntraBetaPrivilegedRoleSetting

## SYNOPSIS

Get role settings.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaPrivilegedRoleSetting
 -ProviderId <String>
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPrivilegedRoleSetting
 -Id <String>
 -ProviderId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaPrivilegedRoleSetting` cmdlet gets role settings from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get role settings for a specific provider and resource

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Filter = "ResourceId eq 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'"
}
Get-EntraBetaPrivilegedRoleSetting @params
```

```Output
Id                                   IsDefault LastUpdatedBy     LastUpdatedDateTime ResourceId                           RoleDefinitionId
--                                   --------- -------------     ------------------- ----------                           ----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False     MG_graph_auth     06/08/2024 05:12:08 22223333-cccc-4444-dddd-5555eeee6666 44445555-eeee-6666-ffff-7777aaaa8888
bbbbbbbb-1111-2222-3333-cccccccccccc False     MG_graph_auth     26/07/2024 12:28:15 11112222-bbbb-3333-cccc-4444dddd5555 55556666-ffff-7777-aaaa-8888bbbb9999
```

This example retrieves role settings for a specific provider and resource.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- In, `-Filter` parameter `ResourceId` specifies the ID of the specific resource.

### Example 2: Get a role setting for a specific provider and Id

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Get-EntraBetaPrivilegedRoleSetting @params
```

```Output
Id                                   IsDefault LastUpdatedBy     LastUpdatedDateTime ResourceId                           RoleDefinitionId
--                                   --------- -------------     ------------------- ----------                           ----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False     MG_graph_auth     06/08/2024 05:12:08 22223333-cccc-4444-dddd-5555eeee6666 44445555-eeee-6666-ffff-7777aaaa8888
```

This example retrieves role settings for a specific provider and Id.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.

### Example 3: Get role settings for a specific provider and resource

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Filter = "ResourceId eq 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'"
}
Get-EntraBetaPrivilegedRoleSetting @params -Top 1
```

```Output
Id                                   IsDefault LastUpdatedBy     LastUpdatedDateTime ResourceId                           RoleDefinitionId
--                                   --------- -------------     ------------------- ----------                           ----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False     MG_graph_auth     06/08/2024 05:12:08 22223333-cccc-4444-dddd-5555eeee6666 44445555-eeee-6666-ffff-7777aaaa8888
```

This example retrieves a top one specific role setting. You can use `-Limit` as an alias for `-Top`.

- `-ProviderId` Parameter specifies the ID of the specific provider.

### Example 4: Get role settings with Filter query

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Filter = "ResourceId eq 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' and LastUpdatedBy  eq 'MOD Administrator'"
}
Get-EntraBetaPrivilegedRoleSetting @params
```

```Output
Id                                   IsDefault LastUpdatedBy     LastUpdatedDateTime ResourceId                           RoleDefinitionId
--                                   --------- -------------     ------------------- ----------                           ----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False     MG_graph_auth     06/08/2024 05:12:08 22223333-cccc-4444-dddd-5555eeee6666 44445555-eeee-6666-ffff-7777aaaa8888
```

This example retrieves role settings for a specific provider and resource.

- `-ProviderId` Parameter specifies the ID of the specific provider.

## PARAMETERS

### -Id

The unique identifier of the specific role setting.

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

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

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

### -ProviderId

The unique identifier of the specific provider.

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

### -Top

The top result count.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

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

### System.String

### System. Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaPrivilegedRoleSetting](Set-EntraBetaPrivilegedRoleSetting.md)
