---
title: Get-EntraUserMembership
description: This article provides details on the Get-EntraUserMembership command.

ms.topic: reference
ms.date: 02/05/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserMembership

schema: 2.0.0
---

# Get-EntraUserMembership

## Synopsis

Get user memberships.

## Syntax

```powershell
Get-EntraUserMembership
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserMembership` cmdlet gets user memberships in Microsoft Entra ID.

## Examples

### Example 1: Get user memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' |
Select-Object Id, displayName, createdDateTime, '@odata.type' |
Format-Table -AutoSize
```

```Output
Id                                   displayName                         createdDateTime      @odata.type
--                                   -----------                         ---------------      -----------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso                             2024-10-06T08:49:16Z #microsoft.graph.group
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Contoso marketing                   2024-10-07T01:17:28Z #microsoft.graph.group
55ff55ff-aa66-bb77-cc88-99dd99dd99dd Pacific Admin Unit                                       #microsoft.graph.administrativeUnit
```

This example demonstrates how to retrieve user memberships in Microsoft Entra ID.

### Example 2: Get All memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' -All |
Select-Object Id, displayName, createdDateTime, '@odata.type' |
Format-Table -AutoSize
```

```Output
Id                                   displayName                         createdDateTime      @odata.type
--                                   -----------                         ---------------      -----------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso                             2024-10-06T08:49:16Z #microsoft.graph.group
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Contoso marketing                   2024-10-07T01:17:28Z #microsoft.graph.group
55ff55ff-aa66-bb77-cc88-99dd99dd99dd Pacific Admin Unit                                       #microsoft.graph.administrativeUnit
```

This example demonstrates how to retrieve users all memberships in Microsoft Entra ID.

### Example 3: Get top three memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' -Top 3 |
Select-Object Id, displayName, createdDateTime, '@odata.type' |
Format-Table -AutoSize
```

```Output
Id                                   displayName                         createdDateTime      @odata.type
--                                   -----------                         ---------------      -----------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso                             2024-10-06T08:49:16Z #microsoft.graph.group
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Contoso marketing                   2024-10-07T01:17:28Z #microsoft.graph.group
55ff55ff-aa66-bb77-cc88-99dd99dd99dd Pacific Admin Unit                                       #microsoft.graph.administrativeUnit
```

This example demonstrates how to retrieve users top three memberships in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 4: List groups that Sawyer Miller is a member of

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' |
Where-Object { $_.'@odata.type' -eq '#microsoft.graph.group' } |
Select-Object Id, displayName, createdDateTime, groupTypes, securityEnabled, visibility, '@odata.type' |
Format-Table -AutoSize
```

```Output
Id                                   displayName                         createdDateTime      groupTypes securityEnabled visibility @odata.type
--                                   -----------                         ---------------      ---------- --------------- ---------- -----------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso                             2024-10-06T08:49:16Z {Unified}            False Public     #microsoft.graph.group
11bb11bb-cc22-dd33-ee44-55ff55ff55ff Mark 8 Project Team                 2024-10-07T00:43:59Z {Unified}             True Public     #microsoft.graph.group
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Leadership                          2024-10-07T00:43:53Z {Unified}             True Private    #microsoft.graph.group
```

This example retrieves the groups a user belongs to. You can also use [Get-EntraUserGroup](https://learn.microsoft.com/powershell/module/microsoft.entra/get-entrausergroup) for the same result.

### Example 5: List a user's directory roles

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' |
Where-Object { $_.'@odata.type' -eq '#microsoft.graph.directoryRole' } |
Select-Object Id, displayName, Description, RoleTemplateId, '@odata.type' |
Format-Table -AutoSize
```

```Output
Id                                   DisplayName               Description                                                                                                     RoleTemplateId                       @odata.type
--                                   -----------               -----------                                                                                                     --------------                       -----------
bbbbbbbb-1111-2222-3333-ccccccccccc  Helpdesk Administrator    Can reset passwords for non-administrators and Helpdesk Administrators.                                        729827e3-9c14-49f7-bb1b-9608f156bbb8 #microsoft.graph.directoryRole
dddddddd-3333-4444-5555-eeeeeeeeeeee Guest Inviter             Can invite guest users independent of the 'members can invite guests' setting.                                 95e79109-95c0-4d8e-aee3-d01accf2d47b #microsoft.graph.directoryRole
```

This example lists a user's assigned directory roles. You can also use [Get-EntraUserRole](https://learn.microsoft.com/powershell/module/microsoft.entra/get-entrauserrole) for the same result.

### Example 6: List a user's administrative units

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' |
Where-Object { $_.'@odata.type' -eq '#microsoft.graph.administrativeUnit' } |
Select-Object Id, displayName, Description, MembershipRule, MembershipType, Visibility |
Format-Table -AutoSize
```

```Output
Id                                   DisplayName                     Description                     MembershipRule MembershipType Visibility
--                                   -----------                     -----------                     -------------- -------------- ----------
dddddddd-3333-4444-5555-eeeeeeeeeeee Pacific Admin Unit              Pacific Administrative Unit
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Engineering Administrative Unit Engineering Admin Unit
```

This example lists a user's administrative units. You can also use [Get-EntraUserAdministrativeUnit](https://learn.microsoft.com/powershell/module/microsoft.entra/get-entrauseradministrativeunit) for the same result.

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

### -UserId

Specifies the ID of a user (as a User Principal Name or ObjectId) in Microsoft Entra ID.

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraUserGroup](Get-EntraUserGroup.md)
