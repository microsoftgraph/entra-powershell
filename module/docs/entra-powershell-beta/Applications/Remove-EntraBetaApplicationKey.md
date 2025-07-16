---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationKey command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationKey
schema: 2.0.0
title: Remove-EntraBetaApplicationKey
---

# Remove-EntraBetaApplicationKey

## SYNOPSIS

Removes a key from an application.

## SYNTAX

```powershell
Remove-EntraBetaApplicationKey
 -ApplicationId <String>
 [-KeyId <String>]
 [-Proof <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Removes a key from an application.

## EXAMPLES

### Example 1: Remove a key credential from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Remove-EntraBetaApplicationKey -ApplicationId $application.Id -KeyId 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333' -Proof '{token}'
```

This command removes the specified key credential from the specified application.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-KeyId` parameter specifies the key Id corresponding to the key object to be removed.
- `-Proof` parameter specifies the JWT token provided as a proof of possession.

## PARAMETERS

### -ApplicationId

Specifies the unique ID of an application in Microsoft Entra ID.

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

## INPUTS

### String

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationKey](New-EntraBetaApplicationKey.md)
