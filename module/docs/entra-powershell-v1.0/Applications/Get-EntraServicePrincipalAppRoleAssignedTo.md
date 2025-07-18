---
author: msewaweru
description: This article provides details on the Get-EntraServicePrincipalAppRoleAssignedTo command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraServicePrincipalAppRoleAssignedTo
schema: 2.0.0
title: Get-EntraServicePrincipalAppRoleAssignedTo
---

# Get-EntraServicePrincipalAppRoleAssignedTo

## SYNOPSIS

Gets app role assignments for this app or service, granted to users, groups and other service principals.

## SYNTAX

```powershell
Get-EntraServicePrincipalAppRoleAssignedTo
 -ServicePrincipalId <String>
 [-All ]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraServicePrincipalAppRoleAssignedTo` cmdlet gets app role assignments for this app or service, granted to users, groups and other service principals.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Synchronization Accounts
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## EXAMPLES

### Example 1: Retrieve the app role assignments

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id
```

This example shows how to get app role assignments for an app or service, granted to users, groups and other service principals.

- The first command gets the ID of a service principal and stores it in the $ServicePrincipalId variable.

- The second command gets the app role assignments for the service principal granted to users, groups and other service principals.

### Example 2: Get all app role assignments

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id -All
```

```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------     -------------------- -----------
                1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:41 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:38 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:37 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:39 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:39 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
```

This command gets the all app role assignments for the service principal granted to users, groups and other service principals.

### Example 3: Get five app role assignments

```powershell
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipal.Id -Top 5
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------     -------------------- -----------
                1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:41 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:38 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:37 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:39 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:39 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
```

This command gets the five app role assignments for the service principal granted to users, groups and other service principals. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

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

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

`Get-EntraServiceAppRoleAssignedTo` is an alias for `Get-EntraServicePrincipalAppRoleAssignedTo`.

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Get-EntraServicePrincipalAppRoleAssignment](Get-EntraServicePrincipalAppRoleAssignment.md)
