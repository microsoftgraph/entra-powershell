---
title: Get-EntraBetaDirectoryRole
description: This article provides details on the Get-EntraBetaDirectoryRole command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 02/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectoryRole

## SYNOPSIS
Gets a directory role.

## SYNTAX

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

## DESCRIPTION
The **Get-EntraBetaDirectoryRole** cmdlet gets a directory role from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a directory role by ID
```powershell
PS C:\>Get-EntraBetaDirectoryRole -ObjectId "019ea7a2-1613-47c9-81cb-20ba35b1ae48"
```

```output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
```

This command gets the specified directory role.

### Example 2: Get all directory roles
```powershell
PS C:\>Get-EntraBetaDirectoryRole
```

```output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
2b3a80bc-51a4-476d-8e09-cd8b6cdde5ea Directory Writers                  Allows access read tasks and a subset of write tasks in the directory.
526b7173-5a6e-49dc-88ec-b677a9093709 User Account Administrator         User Account Administrator has access to perform common user management related tasks.
542f5aef-b23f-4e34-a838-6f2b9205b3d6 Directory Synchronization Accounts Directory Synchronization Accounts
68239fa3-6b01-4396-aeb4-6af38a1b6abf Directory Readers                  Allows access to various read only tasks in the directory.
8c6a5c45-e93e-4f2b-81be-b57ad4c43ddd Privileged Role Administrator      Privileged Role Administrator has access to perform common role management related tasks.
8f8a1cf4-d535-4ccd-8552-7267c7ee0a88 Helpdesk Administrator             Helpdesk Administrator has access to perform common helpdesk related tasks.
b89a48d4-7595-48d0-bb36-69fe4b220668 Device Administrators              Device Administrators
d96eb2b3-0970-4827-8f26-6008efd86511 Security Administrator             Security Administrator allows ability to read and manage security configuration and reports.
```

This command gets all the directory roles.

### Example 3: Get a directory role filter by ObjectId
```powershell
PS C:\>Get-EntraBetaDirectoryRole -Filter "ObjectId eq '019ea7a2-1613-47c9-81cb-20ba35b1ae48'"
```

```output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
```

This command gets the directory role by ObjectId.

### Example 4: Get a directory role filter by displayName
```powershell
PS C:\>Get-EntraBetaDirectoryRole -Filter "displayName eq 'Company Administrator'"
```

```output
ObjectId                             DisplayName                        Description
--------                             -----------                        -----------
019ea7a2-1613-47c9-81cb-20ba35b1ae48 Company Administrator              Company Administrator role has full access to perform any operation in the company scope.
```

This command gets the directory role by display name.

## PARAMETERS

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

### -ObjectId
Specifies the ID of a directory role in Microsoft Entra ID.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Enable-EntraBetaDirectoryRole](Enable-EntraBetaDirectoryRole.md)

