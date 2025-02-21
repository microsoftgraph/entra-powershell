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

Retrieve a user's sponsors (users or groups).

## Syntax

```powershell
Get-EntraBetaUserSponsor
 -UserId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaUserSponsor
 -UserId <String>
 -SponsorId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserSponsor` cmdlet retrieve a user's sponsors (users or groups). The sponsor feature tracks who is responsible for each guest user by assigning a person or group, ensuring accountability.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with `microsoft.directory/users/sponsors/read permission`. The least privileged supported roles are:

- Guest Inviter
- Directory Readers
- Directory Writers
- User Administrator

## Examples

### Example 1: Get the user sponsors

```powershell
Connect-Entra -Scopes 'User.Read', 'User.Read.All' # User.Read.All is application-only permission (non-interactive login)
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

This example shows how to list user sponsors.

- The `-UserId` parameter specifies the User ID or User Principal Name.

### Example 2: Get top one sponsor

```powershell
Connect-Entra -Scopes 'User.Read', 'User.Read.All' # User.Read.All is application-only permission (non-interactive login)
Get-EntraBetaUserSponsor -UserId 'vwyerM@contoso.com' -Top 1 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves the top sponsor for the specified user.

- The `-UserId` parameter specifies the User ID or User Principal Name.

### Example 3: Retrieve the assigned sponsor for a specific user by their SponsorId

```powershell
Connect-Entra -Scopes 'User.Read', 'User.Read.All' # User.Read.All is application-only permission (non-interactive login)
Get-EntraBetaUserSponsor -UserId 'vwyerM@contoso.com' -SponsorId c0c97c58-1895-4910-b1bb-58f96db771df | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves the assigned sponsor for the specified user.

- The `-UserId` parameter specifies the User ID or User Principal Name.
- The `-SponsorId` parameter specifies the specific user's sponsor ID to retrieve.

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