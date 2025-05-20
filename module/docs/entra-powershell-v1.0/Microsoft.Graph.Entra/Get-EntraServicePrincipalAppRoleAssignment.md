---
title: Get-EntraServicePrincipalAppRoleAssignment
description: This article provides details on the Get-EntraServicePrincipalAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalAppRoleAssignment

schema: 2.0.0
---

# Get-EntraServicePrincipalAppRoleAssignment

## Synopsis

Gets a service principal application role assignment.

## Syntax

```powershell
Get-EntraServicePrincipalAppRoleAssignment
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalAppRoleAssignment` cmdlet gets a role assignment for a service principal application in Microsoft Entra ID.

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
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- -------------------
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 29-02-2024 05:53:00 Ask HR               aaaaaaaa-bbbb-cccc-1111-222222222222 Group         M365 License Manager
```

This command gets application role assignments for specified service principal.

- The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. The command stores the ID in the $ServicePrincipalId variable.

- The second command gets the application role assignments for the service principal in identified by $ServicePrincipalId.

### Example 2: Retrieve all application role assignments for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -All
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

This command gets all application role assignments for specified service principal.

### Example 3: Retrieve the top five application role assignments for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -Top 3
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------     -------------------- -----------
                1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:41 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:38 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
                3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 20/10/2023 17:03:37 Entra-App-Testing    aaaaaaaa-bbbb-cccc-1111-222222222222
```

This command gets three application role assignments for specified service principal.

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

`Get-EntraServiceAppRoleAssignment` is an alias for `Get-EntraServicePrincipalAppRoleAssignment`.

## Related links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipalAppRoleAssignment](New-EntraServicePrincipalAppRoleAssignment.md)

[Remove-EntraServicePrincipalAppRoleAssignment](Remove-EntraServicePrincipalAppRoleAssignment.md)
