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
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$params = @{
    ObjectId = '00001111-aaaa-2222-bbbb-3333cccc4444'
    KeyId = 'cccccccc-2d2d-3e3e-4f4f-555555555555'
    Proof = {token}
}

Remove-EntraApplicationKey @params
```

This command removes the specified key credential from the specified application.

## Parameters

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object

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

The key id corresponding to the key object to be removed.

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

## Related Links

[New-EntraApplicationKey](New-EntraApplicationKey.md)
