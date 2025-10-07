---
description: This article provides details on the Get-EntraUserRole command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Users
ms.author: eunicewaweru
ms.date: 12/02/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Get-EntraUserRole
schema: 2.0.0
title: Get-EntraUserRole
---

# Get-EntraUserRole

## SYNOPSIS

Retrieves the list of directory roles assigned to a user.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraUserRole
 -UserId <String>
 [-All]
 [-Filter <String>]
 [-Top <Int32>]
 [-Property <String[]>]
 [-Sort <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraUserRole
 -UserId <String>
 -DirectoryRoleId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserRole` cmdlet Retrieves the list of directory roles assigned to a specific user.

## EXAMPLES

### Example 1: Get list of directory roles assigned to a specific user

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraUserRole -UserId 'SawyerM@contoso.com'
```

```Output
DeletedDateTime         Id                                   DisplayName               RoleTemplateId
---------------         --                                   -----------               --------------
                       bbbbbbbb-1111-2222-3333-ccccccccccc  Helpdesk Administrator    729827e3-9c14-49f7-bb1b-9608f156bbb8
                       dddddddd-3333-4444-5555-eeeeeeeeeeee Directory Readers         88d8e3e3-8f55-4a1e-953a-9b9898b8876b
                       cccccccc-2222-3333-4444-dddddddddddd Application Administrator 9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3
                       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Guest Inviter             95e79109-95c0-4d8e-aee3-d01accf2d47b
```

This cmdlet retrieves the list of directory roles for a specific user.

### Example 2: Get directory roles for a specific user using All parameter

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraUserRole -UserId 'SawyerM@contoso.com' -All
```

```Output
DeletedDateTime         Id                                   DisplayName               RoleTemplateId
---------------         --                                   -----------               --------------
                       bbbbbbbb-1111-2222-3333-ccccccccccc  Helpdesk Administrator    729827e3-9c14-49f7-bb1b-9608f156bbb8
                       dddddddd-3333-4444-5555-eeeeeeeeeeee Directory Readers         88d8e3e3-8f55-4a1e-953a-9b9898b8876b
                       cccccccc-2222-3333-4444-dddddddddddd Application Administrator 9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3
                       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Guest Inviter             95e79109-95c0-4d8e-aee3-d01accf2d47b
```

This cmdlet retrieves the directory roles for a specific user using All parameter.

### Example 3: Get top two directory roles for a specific user

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraUserRole -UserId 'SawyerM@contoso.com' -Top 2
```

```Output
DeletedDateTime         Id                                   DisplayName               RoleTemplateId
---------------         --                                   -----------               --------------
                       bbbbbbbb-1111-2222-3333-ccccccccccc  Helpdesk Administrator    729827e3-9c14-49f7-bb1b-9608f156bbb8
                       dddddddd-3333-4444-5555-eeeeeeeeeeee Directory Readers         88d8e3e3-8f55-4a1e-953a-9b9898b8876b
```

This cmdlet retrieves top two directory roles for a specific user. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get assigned directory roles for a specific user by DirectoryRoleId

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$role = Get-EntraDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
Get-EntraUserRole -UserId 'SawyerM@contoso.com' -DirectoryRoleId $role.Id
```

```Output
DeletedDateTime         Id                                   DisplayName               RoleTemplateId
---------------         --                                   -----------               --------------
                       bbbbbbbb-1111-2222-3333-ccccccccccc  Helpdesk Administrator    729827e3-9c14-49f7-bb1b-9608f156bbb8
```

This cmdlet retrieves the directory roles for a specific user by DirectoryRoleId parameter.

- `-DirectoryRoleId` parameter specifies the Directory role ID.

## PARAMETERS

### -UserId

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

The maximum number of the directory roles assigned to a specific user.

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

### -Filter

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

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

### -Sort

Order items by property values.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: OrderBy

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DirectoryRoleId

The unique ID of the directory role.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: DirectoryRoleObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraUserMembership](Get-EntraUserMembership.md)
