---
title: Get-EntraBetaUserOwnedObject
description: This article provides details on the Get-EntraBetaUserOwnedObject command.


ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserOwnedObject

schema: 2.0.0
---

# Get-EntraBetaUserOwnedObject

## Synopsis

Get objects owned by a user.

## Syntax

```powershell
Get-EntraBetaUserOwnedObject
 -UserId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserOwnedObject` cmdlet gets objects owned by a user in Microsoft Entra ID. Specify `UserId` parameter to get objects owned by user.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -UserId 'SawyerM@contoso.com' | 
	Select-Object Id, displayName, createdDateTime, '@odata.type' |
    Format-Table -AutoSize
```

```Output
id                                    displayName                  createdDateTime           @odata.type
--                                    -----------                  ---------------           -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Helpdesk Application         10/17/2024 5:05:54 AM     #microsoft.graph.application
bbbbbbbb-1111-2222-3333-cccccccccccc  Contoso Group                10/21/2024 6:25:19 PM     #microsoft.graph.group
cccccccc-2222-3333-4444-dddddddddddd  ClaimIssuancePolicy                                    #microsoft.graph.tokenLifetimePolicy
ffffffff-4444-5555-6666-gggggggggggg  Contoso Marketing App        10/23/2024 3:17:14 PM     #microsoft.graph.application
```

This example retrieves objects owned by the specified user.

- `-UserId` Parameter specifies the ID of a user as a UserPrincipalName or UserId.

### Example 2: Get all objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -UserId 'SawyerM@contoso.com' -All | 
	Select-Object Id, displayName, createdDateTime, '@odata.type' |
    Format-Table -AutoSize
```

```Output
id                                    displayName                  createdDateTime           @odata.type
--                                    -----------                  ---------------           -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Helpdesk Application         10/17/2024 5:05:54 AM     #microsoft.graph.application
bbbbbbbb-1111-2222-3333-cccccccccccc  Contoso Group                10/21/2024 6:25:19 PM     #microsoft.graph.group
cccccccc-2222-3333-4444-dddddddddddd  ClaimIssuancePolicy                                    #microsoft.graph.tokenLifetimePolicy
ffffffff-4444-5555-6666-gggggggggggg  Contoso Marketing App        10/23/2024 3:17:14 PM     #microsoft.graph.application
```

This example retrieves all the objects owned by the specified user.

- `-UserId` parameter specifies the ID of a user as a UserPrincipalName or UserId.

### Example 3: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -UserId 'SawyerM@contoso.com' -Top 3 | 
	Select-Object Id, displayName, createdDateTime, '@odata.type' |
    Format-Table -AutoSize
```

```Output
id                                    displayName                  createdDateTime           @odata.type
--                                    -----------                  ---------------           -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Helpdesk Application         10/17/2024 5:05:54 AM     #microsoft.graph.application
bbbbbbbb-1111-2222-3333-cccccccccccc  Contoso Group                10/21/2024 6:25:19 PM     #microsoft.graph.group
cccccccc-2222-3333-4444-dddddddddddd  ClaimIssuancePolicy                                    #microsoft.graph.tokenLifetimePolicy
```

This example retrieves the top three objects owned by the specified user.

- `-UserId` parameter specifies the ID of a user as a UserPrincipalName or UserId.

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

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

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

## Related links
