---
title: Get-EntraUserSponsor
description: This article provides details on the Get-EntraUserSponsor command.

ms.topic: reference
ms.date: 03/06/2025
ms.author: eunicewaweru
ms.reviewer: dbutoyi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserSponsor

schema: 2.0.0
---

# Get-EntraUserSponsor

## Synopsis

Retrieve a user's sponsors (users or groups).

## Syntax

### GetQuery

```powershell
Get-EntraUserSponsor
 -UserId <String>
 -Filter <String>
 -Top <Int32>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraUserSponsor
 -UserId <String>
 -SponsorId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserSponsor` cmdlet retrieve a user's sponsors (users or groups). The sponsor feature tracks who is responsible for each guest user by assigning a person or group, ensuring accountability.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with `microsoft.directory/users/sponsors/read permission`. The least privileged supported roles are:

- Guest Inviter
- Directory Readers
- Directory Writers
- User Administrator

## Examples

### Example 1: Get the user sponsors

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserSponsor -UserId 'SawyerM@contoso.com' -All |
Select-Object Id, DisplayName, '@odata.type', CreatedDateTime | Format-Table -AutoSize
```

```Output
id                                   displayName                 @odata.type                createdDateTime          
--                                   -----------                 -----------                ---------------          
cccccccc-2222-3333-4444-dddddddddddd Angel Brown(Fabrikam)       #microsoft.graph.user      3/7/2024 3:10:31 AM      
eeeeeeee-4444-5555-6666-ffffffffffff Fabrikam Helpdesk Group     #microsoft.graph.group     8/7/2024 2:52:47 PM
```

This example shows how to list user sponsors.

- The `-UserId` parameter specifies the User ID or User Principal Name.

### Example 2: Get top one sponsor

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserSponsor -UserId 'SawyerM@contoso.com' -Top 1 |
Select-Object Id, DisplayName, '@odata.type', CreatedDateTime | Format-Table -AutoSize
```

```Output
id                                   displayName                 @odata.type                createdDateTime          
--                                   -----------                 -----------                ---------------          
cccccccc-2222-3333-4444-dddddddddddd Angel Brown(Fabrikam)       #microsoft.graph.user      3/7/2024 3:10:31 AM
```

This example retrieves the top sponsor for the specified user. You can use `-Limit` as an alias for `-Top`.

- The `-UserId` parameter specifies the User ID or User Principal Name.

### Example 3: Retrieve the assigned sponsor for a specific user by their SponsorId

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserSponsor -UserId 'SawyerM@contoso.com' -SponsorId 'cccccccc-2222-3333-4444-dddddddddddd' |
Select-Object Id, DisplayName, '@odata.type', CreatedDateTime | Format-Table -AutoSize
```

```Output
id                                   displayName                 @odata.type                createdDateTime          
--                                   -----------                 -----------                ---------------          
cccccccc-2222-3333-4444-dddddddddddd Angel Brown(Fabrikam)       #microsoft.graph.user      3/7/2024 3:10:31 AM      
eeeeeeee-4444-5555-6666-ffffffffffff Fabrikam Helpdesk Group     #microsoft.graph.group     8/7/2024 2:52:47 PM
```

This example retrieves the assigned sponsor for the specified user.

- The `-UserId` parameter specifies the User ID or User Principal Name.
- The `-SponsorId` parameter specifies the specific user's sponsor ID to retrieve (user or group ID).

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

Specifies the ID (as a UserPrincipalName or UserId) of a user in Microsoft Entra ID.

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

### -SponsorId

Specifies the specific user's sponsor ID to retrieve (user or group ID).

```yaml
Type: System.String
Parameter Sets: (All)

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

## Outputs

## Notes

## Related links

[Set-EntraUserSponsor](Set-EntraUserSponsor.md)

[Remove-EntraUserSponsor](Remove-EntraUserSponsor.md)
