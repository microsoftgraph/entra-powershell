---
title: Get-EntraUserMembership
description: This article provides details on the Get-EntraUserMembership command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserMembership

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

### Example 2: Get user memberships with additional details

```powershell
Connect-Entra -Scopes 'User.Read'
$userMemberships = Get-EntraUserMembership -ObjectId 'SawyerM@contoso.com'
$membershipDetails = $userMemberships | ForEach-Object {
    $membershipDetail = Get-EntraObjectByObjectId -ObjectIds $_.Id
    [PSCustomObject]@{
        odataType   = $membershipDetail.'@odata.type'
        displayName = $membershipDetail.displayName
        Id          = $membershipDetail.Id
    }
}
$membershipDetails | Select-Object odataType, displayName, Id
```

```Output
odataType                      displayName                         Id
---------                      -----------                         --
#microsoft.graph.group         Contoso Group                       33dd33dd-ee44-ff55-aa66-77bb77bb77bb
#microsoft.graph.group         Helpdesk Group                      55ff55ff-aa66-bb77-cc88-99dd99dd99dd
#microsoft.graph.directoryRole Attribute Assignment Reader         22cc22cc-dd33-ee44-ff55-66aa66aa66aa
#microsoft.graph.directoryRole Attribute Definition Reader         11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This example demonstrates how to retrieve user memberships in Microsoft Entra ID with more lookup details.

### Example 3: Get All memberships

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

### Example 4: Get top three memberships

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

This example demonstrates how to retrieve users top three memberships in Microsoft Entra ID.

### Example 5: List groups that Sawyer Miller is a member of

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserMembership -UserId 'SawyerM@contoso.com' | 
	Where-Object {$_.'@odata.type' -eq '#microsoft.graph.group'} |
    Select-Object Id, displayName, createdDateTime, groupTypes, securityEnabled, visibility, '@odata.type' |
    Format-Table -AutoSize
```

```Output
Id                                   displayName                         createdDateTime      groupTypes securityEnabled visibility @odata.type
--                                   -----------                         ---------------      ---------- --------------- ---------- -----------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso                             2024-10-06T08:49:16Z {Unified}            False Public     #microsoft.graph.group
11bb11bb-cc22-dd33-ee44-55ff55ff55ff Sales and Marketing                 2024-10-07T00:43:47Z {Unified}             True Public     #microsoft.graph.group
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Retail                              2024-10-07T00:44:06Z {Unified}             True Private    #microsoft.graph.groupp
33dd33dd-ee44-ff55-aa66-77bb77bb77bb sg-Sales and Marketing              2024-10-07T00:45:16Z {}                    True            #microsoft.graph.group
44ee44ee-ff55-aa66-bb77-88cc88cc88cc All Employees                       2024-10-07T00:57:05Z {}                   False            #microsoft.graph.group
55ff55ff-aa66-bb77-cc88-99dd99dd99dd Communications                      2024-10-07T01:12:09Z {Unified}            False Private    #microsoft.graph.group
```

This example demonstrates how to retrieve the groups that a user is a member of.

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

## Related links
