---
author: msewaweru
description: This article provides details on the Get-EntraBetaServicePrincipalAppRoleAssignment command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalAppRoleAssignment
schema: 2.0.0
title: Get-EntraBetaServicePrincipalAppRoleAssignment
---

# Get-EntraBetaServicePrincipalAppRoleAssignment

## SYNOPSIS

Gets a service principal application role assignment.

## SYNTAX

```powershell
Get-EntraBetaServicePrincipalAppRoleAssignment
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaServicePrincipalAppRoleAssignment` cmdlet gets a role assignment for a service principal application in Microsoft Entra ID.

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

### Example 1: Retrieve the application role assignments for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User          ProvisioningPowerBi 021510b7-e753-40…
```

This command gets application role assignments for specified service principal. You can use the command `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ServicePrincipalId` parameter specifies the service principal Id.

### Example 2: Retrieve all application role assignments for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -All
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User          ProvisioningPowerBi 021510b7-e753-40…
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User1          ProvisioningPowerBi 021510b7-e753-40…
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User2          ProvisioningPowerBi 021510b7-e753-40…
4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User3          ProvisioningPowerBi 021510b7-e753-40…
5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User4          ProvisioningPowerBi 021510b7-e753-40…
```

This command gets all application role assignments for specified service principal.

- `-ServicePrincipalId` parameter specifies the service principal Id.

### Example 3: Retrieve the top three application role assignments for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -Top 3
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User          ProvisioningPowerBi 021510b7-e753-40…
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User1          ProvisioningPowerBi 021510b7-e753-40…
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User2          ProvisioningPowerBi 021510b7-e753-40…
```

This command gets top three application role assignments for specified service principal. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the service principal Id.

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

The maximum number of records to return.

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

## INPUTS

## OUTPUTS

## NOTES

`Get-EntraBetaServiceAppRoleAssignment` is an alias for `Get-EntraBetaServicePrincipalAppRoleAssignment`.

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[New-EntraBetaServicePrincipalAppRoleAssignment](New-EntraBetaServicePrincipalAppRoleAssignment.md)

[Remove-EntraBetaServicePrincipalAppRoleAssignment](Remove-EntraBetaServicePrincipalAppRoleAssignment.md)
