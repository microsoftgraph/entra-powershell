---
title: Remove-EntraBetaApplicationKeyCredential
description: This article provides details on the Remove-EntraBetaApplicationKeyCredential command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationKeyCredential

schema: 2.0.0
---

# Remove-EntraBetaApplicationKeyCredential

## Synopsis

Removes a key credential from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationKeyCredential
 -ApplicationId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationKeyCredential` cmdlet removes a key credential from an application.

An application can use this command along with `New-EntraBetaApplicationKeyCredential` to automate the rolling of its expiring keys.

## Examples

### Example 1: Remove a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Remove-EntraBetaApplicationKeyCredential -ApplicationId $application.Id -KeyId 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
```

This command removes the specified key credential from the specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-KeyId` Specifies a custom key ID. Use `Get-EntraBetaApplicationKeyCredential` to get the keyId details.

## Parameters

### -KeyId

Specifies a custom key ID. The unique identifier for the password.

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

### -ApplicationId

Specifies a unique ID of an application in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaApplicationKeyCredential](Get-EntraBetaApplicationKeyCredential.md)

[New-EntraBetaApplicationKeyCredential](New-EntraBetaApplicationKeyCredential.md)
