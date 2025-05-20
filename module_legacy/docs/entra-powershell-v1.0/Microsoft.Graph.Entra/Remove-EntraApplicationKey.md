---
title: Remove-EntraApplicationKey
description: This article provides details on the Remove-EntraApplicationKey command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraApplicationKey

schema: 2.0.0
---

# Remove-EntraApplicationKey

## Synopsis

Removes a key from an application.

## Syntax

```powershell
Remove-EntraApplicationKey
 -ObjectId <String>
 [-Proof <String>]
 [-KeyId <String>]
 [<CommonParameters>]
```

## Description

Removes a key from an application.

## Examples

### Example 1: Removes a key credential from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Directory.ReadWrite.All'
$app = Get-EntraApplication -Filter "DisplayName eq '<application-display-name>'"
$params = @{
    ObjectId = $app.ObjectId
    KeyId = 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
    Proof = {token}
}

Remove-EntraApplicationKey @params
```

This command removes the specified key credential from the specified application.

- `-ObjectId` parameter specifies the unique identifier of an application.
- `-KeyId` parameter specifies the key Id corresponding to the key object to be removed.
- `-Proof` parameter specifies the JWT token provided as a proof of possession.

## Parameters

### -ObjectId

Specifies the unique ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -KeyId

The key Id corresponding to the key object to be removed.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proof

The JWT token provided as a proof of possession.

A self-signed JWT token used as a proof of possession of the existing keys. This JWT token must be signed with a private key that corresponds to one of the existing valid certificates associated with the application. The token should contain the following claims:

- `aud`: Audience needs to be 00000002-0000-0000-c000-000000000000.
- `iss`: Issuer needs to be the ID of the application that initiates the request.
- `nbf`: Not before time.
- `exp`: Expiration time should be the value of nbf + 10 minutes.

```yaml
Type: System.String
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

### String

## Outputs

## Notes

## Related links

[New-EntraApplicationKey](New-EntraApplicationKey.md)
