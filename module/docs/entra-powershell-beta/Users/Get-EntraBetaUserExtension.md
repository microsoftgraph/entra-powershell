---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserExtension command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/25/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserExtension
schema: 2.0.0
title: Get-EntraBetaUserExtension
---

# Get-EntraBetaUserExtension

## SYNOPSIS

Gets a user extension.

## SYNTAX

```powershell
Get-EntraBetaUserExtension
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserExtension` cmdlet gets a user extension in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve extension attributes for a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserExtension -UserId 'SawyerM@contoso.com'
```

```Output
onPremisesDistinguishedName :
@odata.context              : https://graph.microsoft.com/beta/$metadata#users(identities,onPremisesDistinguishedName,employeeId,createdDateTime)/$entity
identities                  : {@{issuer=SawyerM@contoso.com; signInType=userPrincipalName; issuerAssignedId=SawyerM@contoso.com}}
employeeId                  :
id                          : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
createdDateTime             : 18/07/2024 05:13:40
userIdentities              : {@{issuer=SawyerM@contoso.com; signInType=userPrincipalName; issuerAssignedId=SawyerM@contoso.com}}
```

This example shows how to retrieve the extension attributes for a specified user.

- `-UserId` parameter specifies the user object Id.

## PARAMETERS

### -UserId

Specifies the ID of a user's UserPrincipalName or UserId in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaUserExtension](Remove-EntraBetaUserExtension.md)

[Set-EntraBetaUserExtension](Set-EntraBetaUserExtension.md)
