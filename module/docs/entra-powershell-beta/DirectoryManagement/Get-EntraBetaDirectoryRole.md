---
author: msewaweru
description: This article provides details on the Get-EntraBetaDirectoryRole command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDirectoryRole
schema: 2.0.0
title: Get-EntraBetaDirectoryRole
---

# Get-EntraBetaDirectoryRole

## Synopsis

Gets a directory role.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDirectoryRole
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDirectoryRole
 -DirectoryRoleId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryRole` cmdlet gets a directory role from Microsoft Entra ID. Specify `DirectoryRoleId` parameter to get a directory role.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported for this operation:

- User Administrator  
- Helpdesk Administrator  
- Service Support Administrator  
- Billing Administrator  
- Directory Readers  
- Directory Writers  
- Application Administrator  
- Security Reader  
- Security Administrator  
- Privileged Role Administrator  
- Cloud Application Administrator

## Examples

### Example 1: Get a directory role by ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$directoryRole = Get-EntraBetaDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
Get-EntraBetaDirectoryRole -DirectoryRoleId $directoryRole.Id
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the specified directory role.

- `-DirectoryRoleId` parameter specifies the ID of a directory role in Microsoft Entra ID.

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

### Example 3: Get a directory role filter by Id

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole -Filter "Id eq 'c0e36062-8c80-4d72-9bc3-cbb4efe03c21'"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the directory role by Id.

- `-Id` parameter specifies the ID of a directory role in Microsoft Entra ID.

### Example 4: Get a directory role filter by displayName

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Perform all migration functionality to migrate content to Microsoft 365 usin...
```

This command gets the directory role by display name.

## Parameters

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

### -DirectoryRoleId

Specifies the ID of a directory role in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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

## Inputs

## Outputs

## Notes

## Related links

[Enable-EntraBetaDirectoryRole](Enable-EntraBetaDirectoryRole.md)
