---
author: msewaweru
description: This article provides details on the Remove-EntraUserSponsor command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Users
ms.author: eunicewaweru
ms.date: 03/07/2025
ms.reviewer: dbutoyi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Remove-EntraUserSponsor
schema: 2.0.0
title: Remove-EntraUserSponsor
---

# Remove-EntraUserSponsor

## SYNOPSIS

Removes a sponsor from a user.

## SYNTAX

```powershell
Remove-EntraUserSponsor
 -UserId <String>
 -SponsorId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraUserSponsor` cmdlet removes a sponsor relationship from a user. Sponsors are users and groups that are responsible for a guest's privileges in the tenant and for keeping the guest's information and access up to date. This cmdlet removes that sponsorship relationship. Specify `UserId` and `SponsorId` parameters to remove a user sponsor.

## EXAMPLES

### Example 1: Remove a user sponsor via pipelining

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraUserSponsor -UserId 'SawyerM@contoso.com' | Where-Object { $_.displayName -eq 'Adele Vance (Fabrikam)' } | Remove-EntraUserSponsor
```

This example demonstrates how to remove a user sponsor.

- `UserId` parameter specifies the UserId or User Principal Name of the User.

### Example 2: Remove a user sponsor

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$sponsor = Get-EntraUserSponsor -UserId 'SawyerM@contoso.com' -Top 1
Remove-EntraUserSponsor -UserId 'SawyerM@Contoso.com' -SponsorId $sponsor.Id
```

This example demonstrates how to remove a user sponsor.

- `UserId` parameter specifies the UserId or User Principal Name of the User.
- `SponsorId` parameter specifies the ID of the sponsor to remove.

## PARAMETERS

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

Specifies the ID of the sponsor (user or group) to be removed.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: DirectoryObjectId
Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUserSponsor](Get-EntraUserSponsor.md)

[Set-EntraUserSponsor](Set-EntraUserSponsor.md)
