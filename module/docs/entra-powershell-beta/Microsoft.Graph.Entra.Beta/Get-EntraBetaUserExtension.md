---
title: Get-EntraBetaUserExtension
description: This article provides details on the Get-EntraBetaUserExtension command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserExtension

schema: 2.0.0
---

# Get-EntraBetaUserExtension

## Synopsis

Gets a user extension.

## Syntax

```powershell
Get-EntraBetaUserExtension
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserExtension` cmdlet gets a user extension in Microsoft Entra ID.

## Examples

### Example 1: Retrieve extension attributes for a user

```powershell
Connect-Entra -Scopes 'User.Read'
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

## Parameters

### -UserId

Specifies the ID of an object.

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

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaUserExtension](Remove-EntraBetaUserExtension.md)

[Set-EntraBetaUserExtension](Set-EntraBetaUserExtension.md)
