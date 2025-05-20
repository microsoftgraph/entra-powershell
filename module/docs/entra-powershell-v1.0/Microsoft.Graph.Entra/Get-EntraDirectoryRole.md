---
title: Get-EntraDirectoryRole
description: This article provides details on the Get-EntraDirectoryRole command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDirectoryRole

schema: 2.0.0
---

# Get-EntraDirectoryRole

## Synopsis

Gets a directory role.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDirectoryRole
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDirectoryRole
 -DirectoryRoleId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDirectoryRole` cmdlet gets a directory role from Microsoft Entra ID. Specify `ObjectId` parameter to get a directory role.

## Examples

### Example 1: Get a directory role by ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRole -DirectoryRoleId '019ea7a2-1613-47c9-81cb-20ba35b1ae48'
```

```Output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
```

This command gets the specified directory role.

- `-ObjectId` parameter specifies the ID of a directory role in Microsoft Entra ID.

### Example 2: Get all directory roles

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRole
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
Get-EntraDirectoryRole -Filter "ObjectId eq '019ea7a2-1613-47c9-81cb-20ba35b1ae48'"
```

```Output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
```

This command gets the directory role by ObjectId.

- `-ObjectId` parameter specifies the ID of a directory role in Microsoft Entra ID.

### Example 4: Get a directory role filter by displayName

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                56644e28-bf8b-4dad-8595-24448ffa3cb8 Perform all migration functionality to migrate content to Microsoft 365 usin...
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
Aliases:

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

[Enable-EntraDirectoryRole](Enable-EntraDirectoryRole.md)
