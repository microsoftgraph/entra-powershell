---
author: msewaweru
description: This article provides details on the Get-EntraBetaServicePrincipalAppRoleAssignedTo command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalAppRoleAssignedTo
schema: 2.0.0
title: Get-EntraBetaServicePrincipalAppRoleAssignedTo
---

# Get-EntraBetaServicePrincipalAppRoleAssignedTo

## Synopsis

Gets app role assignments for this app or service, granted to users, groups, and other service principals.

## Syntax

```powershell
Get-EntraBetaServicePrincipalAppRoleAssignedTo
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalAppRoleAssignedTo` cmdlet gets app role assignments for this app or service, granted to users, groups, and other service principals.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Synchronization Accounts
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## Examples

### Example 1: Get app role assignment by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Helpdesk Application                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Helpdesk Application
```

This example shows how to get app role assignments for an app or service, granted to users, groups, and other service principals.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Get all app role assignments

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id -All
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 aaaa0000-bb11-2222-33cc-444444dddddd
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 bbbb1111-cc22-3333-44dd-555555eeeeee
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 cccc2222-dd33-4444-55ee-666666ffffff
4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 dddd3333-ee44-5555-66ff-777777aaaaaa
5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 eeee4444-ff55-6666-77aa-888888bbbbbb
```

This command gets the all app role assignments for the service principal granted to users, groups, and other service principals.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 3: Get five app role assignments

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id -Top 5
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 aaaa0000-bb11-2222-33cc-444444dddddd
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 bbbb1111-cc22-3333-44dd-555555eeeeee
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 cccc2222-dd33-4444-55ee-666666ffffff
4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 dddd3333-ee44-5555-66ff-777777aaaaaa
5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 eeee4444-ff55-6666-77aa-888888bbbbbb
```

This command gets the five app role assignments for the service principal granted to users, groups, and other service principals. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the service principal ID.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
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

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

`Get-EntraBetaServiceAppRoleAssignedTo` is an alias for `Get-EntraBetaServicePrincipalAppRoleAssignedTo`.

## Related links

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalAppRoleAssignment](Get-EntraBetaServicePrincipalAppRoleAssignment.md)
