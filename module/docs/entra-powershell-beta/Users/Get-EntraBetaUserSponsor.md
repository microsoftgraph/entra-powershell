---
title: Get-EntraBetaUserSponsor
description: This article provides details on the Get-EntraBetaUserSponsor command.

ms.topic: reference
ms.date: 02/10/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

schema: 2.0.0
---

# Get-EntraBetaUserSponsor

## Synopsis

List sponsor for a user.

## Syntax

```powershell
Get-EntraBetaUserSponsor
 -UserId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserSponsor` cmdlet gets a user sponsors. Sponsors are users and groups that are responsible for this guest's privileges in the tenant and for keeping the guest's information and access up to date.

Specify `UserId` parameter to get the specific manager of user.

## Examples

### Example 1: Get the user sponsors

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserSponsor -UserId 'SawyerM@contoso.com' |
Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
Format-Table -AutoSize
```

```Output
id                                   displayName     userPrincipalName              createdDateTime     accountEnabled userType
--                                   -----------     -----------------             ---------------     -------------- --------
c0c97c58-1895-4910-b1bb-58f96db771df Adele Vance     AdeleV@7svz8d.onmicrosoft.com 28/10/2024 09:50:43           True Member
79984fce-9e33-497a-a5a2-b3c85e3fedcb Alex Wilber     AlexW@7svz8d.onmicrosoft.com  28/10/2024 09:50:46           True Member
406e3c9f-7a2d-4ef0-b1d4-69ddbd2719bb Diego Siciliani DiegoS@7svz8d.onmicrosoft.com 28/10/2024 09:50:46           True Member
```

This example demonstrates how to list the user sponsors.

- `-UserId` Parameter specifies UserId or User Principal Name of User.

### Example 2: Get top one sponsor

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserSponsor -UserId 'vwyerM@contoso.com' -Top 1 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves top one sponsor for the specified user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or UserId).

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

## Related Links