---
title: Get-EntraBetaServicePrincipalAppRoleAssignment
description: This article provides details on the Get-EntraBetaServicePrincipalAppRoleAssignment command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalAppRoleAssignment

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalAppRoleAssignment

## Synopsis

Gets a service principal application role assignment.

## Syntax

```powershell
Get-EntraBetaServicePrincipalAppRoleAssignment
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

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

## Examples

### Example 1: Retrieve the application role assignments for a service principal

```powershell
 Connect-Entra -Scopes 'Application.Read.All'
 $ServicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
 Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipal.ObjectId
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
 $ServicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
 Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipal.ObjectId -All
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
$ServicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraBetaServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipal.ObjectId -Top 3
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User          ProvisioningPowerBi 021510b7-e753-40…
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User1          ProvisioningPowerBi 021510b7-e753-40…
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 07-07-2023 17:03:59 MOD Administrator    aaaaaaaa-bbbb-cccc-1111-222222222222 User2          ProvisioningPowerBi 021510b7-e753-40…
```

This command gets top three application role assignments for specified service principal.

- `-ServicePrincipalId` parameter specifies the service principal Id.

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

The maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

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

`Get-EntraBetaServiceAppRoleAssignment` is an alias for `Get-EntraBetaServicePrincipalAppRoleAssignment`.

## Related Links

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[New-EntraBetaServicePrincipalAppRoleAssignment](New-EntraBetaServicePrincipalAppRoleAssignment.md)

[Remove-EntraBetaServicePrincipalAppRoleAssignment](Remove-EntraBetaServicePrincipalAppRoleAssignment.md)
