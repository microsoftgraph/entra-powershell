---
author: msewaweru
description: This article provides details on the Get-EntraUserExtension command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 04/26/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserExtension
schema: 2.0.0
title: Get-EntraUserExtension
---

# Get-EntraUserExtension

## SYNOPSIS

Gets a user's extension.

## SYNTAX

```powershell
Get-EntraUserExtension
 -UserId <String>
 [-Property <String[]>]
 [-IsSyncedFromOnPremises <String>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserExtension` cmdlet retrieves extensions for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve extension attributes for a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserExtension -UserId 'SawyerM@contoso.com'
```

```Output
id                          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userPrincipalName           : sawyerm@contoso.com
employeeId                  :
identities                  : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=sawyerm@contoso.com}}
onPremisesDistinguishedName :
createdDateTime             : 3/7/2024 12:34:59 AM
userIdentities              : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=sawyerm@contoso.com}}
```

This example shows how to retrieve the extension attributes for a specified user.

- `-UserId` parameter specifies the user object ID.

### Example 2: Retrieve extension attributes for a user synced from on-premises

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserExtension -UserId 'SawyerM@contoso.com' -IsSyncedFromOnPremises $true
```

```Output
id                          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userPrincipalName           : sawyerm@contoso.com
employeeId                  :
identities                  : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=sawyerm@contoso.com}}
onPremisesDistinguishedName :
createdDateTime             : 3/7/2024 12:34:59 AM
userIdentities              : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=sawyerm@contoso.com}}
```

This example shows how to retrieve the extension attributes for a specified user whose extensions are synced from on-premises.

- `-UserId` parameter specifies the user object ID.

## PARAMETERS

### -UserId

Specifies the ID of an object.

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

### -IsSyncedFromOnPremises

Filter to only show user's extensions synced from on-premises.

```yaml
Type: System.String
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

## RELATED LINKS

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)

[Set-EntraUserExtension](Set-EntraUserExtension.md)
