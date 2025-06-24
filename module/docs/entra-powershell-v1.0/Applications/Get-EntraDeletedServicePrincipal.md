---
description: This article provides details on the Get-EntraDeletedServicePrincipal command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedServicePrincipal
schema: 2.0.0
title: Get-EntraDeletedServicePrincipal
---

# Get-EntraDeletedServicePrincipal

## Synopsis

Retrieves the list of previously deleted service principals.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDeletedServicePrincipal
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDeletedServicePrincipal
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDeletedServicePrincipal
 -ServicePrincipalId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeletedServicePrincipal` cmdlet Retrieves the list of previously deleted service principals.

## Examples

### Example 1: Get list of deleted service principals

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb ProjectWorkManagement  22223333-cccc-4444-dddd-5555eeee6666 2/12/2025 11:07:56 AM                 8  ManagedIdentity
dddddddd-3333-4444-5555-eeeeeeeeeeee Enterprise App1        33334444-dddd-5555-eeee-6666ffff7777 2/11/2025 11:07:56 AM                 11 ManagedIdentity
```

This cmdlet retrieves the list of deleted service principals.

### Example 2: Get list of deleted service principals using All parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -All | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb ProjectWorkManagement  22223333-cccc-4444-dddd-5555eeee6666 2/12/2025 11:07:56 AM                 8  ManagedIdentity
dddddddd-3333-4444-5555-eeeeeeeeeeee Enterprise App1        33334444-dddd-5555-eeee-6666ffff7777 2/11/2025 11:07:56 AM                 11 ManagedIdentity
```

This cmdlet retrieves the list of deleted service principals using All parameter.

### Example 3: Get top two deleted service principals

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -Top 2 | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb ProjectWorkManagement  22223333-cccc-4444-dddd-5555eeee6666 2/12/2025 11:07:56 AM                 8  ManagedIdentity
```

This cmdlet retrieves top two deleted service principals. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted service principals using SearchString parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -SearchString 'Contoso Marketing' | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
```

This cmdlet retrieves deleted service principals using SearchString parameter.

### Example 5: Get deleted service principals filter by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -Filter "DisplayName eq 'Contoso Marketing'" | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
```

This cmdlet retrieves deleted service principals having specified display name.

### Example 6: Get deleted service principal by ServicePrincipalId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -ServicePrincipalId 'bbbbbbbb-1111-2222-3333-cccccccccccc' | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays, ServicePrincipalType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName            AppId                                DeletedDateTime       DeletionAgeInDays ServicePrincipalType
--                                   -----------            -----                                ---------------       ----------------- --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Marketing      00001111-aaaa-2222-bbbb-3333cccc4444 2/10/2025 11:07:07 AM                 10 Application
```

This cmdlet retrieves the deleted service principal specified by ServicePrincipalId.

- `-ServicePrincipalId` parameter specifies the deleted service principal Id.

## Parameters

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

### -Filter

Retrieve only those deleted service principals that satisfy the filter.

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

### -SearchString

Retrieve only those service principals that satisfy the -SearchString value.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

The maximum number of service principals.

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

### -ServicePrincipalId

The unique ID of the deleted service principal to be retrieved.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraApplication](Get-EntraApplication.md)
