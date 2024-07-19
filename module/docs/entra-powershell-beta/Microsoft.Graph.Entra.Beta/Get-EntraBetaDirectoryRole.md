---
title: Get-EntraBetaDirectoryRole
description: This article provides details on the Get-EntraBetaDirectoryRole command.


ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectoryRole

## Synopsis

Gets a directory role.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDirectoryRole 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDirectoryRole 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryRole` cmdlet gets a directory role from Microsoft Entra ID. Specify `ObjectId` parameter to get a directory role.

## Examples

### Example 1: Get a directory role by ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the specified directory role.

- `ObjectId` parameter specifies the ID of a directory role in Microsoft Entra ID.

### Example 2: Get all directory roles

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
                aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb Can manage all aspects of users and groups, including resetting passwords fo...
                bbbbbbbb-7777-8888-9999-cccccccccccc Can read basic directory information. Commonly used to grant directory read ...
                cccccccc-8888-9999-0000-dddddddddddd Can read and write basic directory information. For granting access to appli...
```

This command gets all the directory roles.

### Example 3: Get a directory role filter by ObjectId

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole -Filter "ObjectId eq 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the directory role by ObjectId.

- `ObjectId` parameter specifies the ID of a directory role in Microsoft Entra ID.

### Example 4: Get a directory role filter by displayName

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole -Filter "displayName eq 'Company Administrator'"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the directory role by display name.

## Parameters

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

### -ObjectId

Specifies the ID of a directory role in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Enable-EntraBetaDirectoryRole](Enable-EntraBetaDirectoryRole.md)
