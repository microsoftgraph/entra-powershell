---
author: msewaweru
description: This article provides details on the Remove-EntraApplicationKeyCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationKeyCredential
schema: 2.0.0
title: Remove-EntraApplicationKeyCredential
---

# Remove-EntraApplicationKeyCredential

## SYNOPSIS

Removes a key credential from an application.

## SYNTAX

```powershell
Remove-EntraApplicationKeyCredential
 -ApplicationId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraApplicationKeyCredential` cmdlet removes a key credential from an application.

An application can use this command along with `New-EntraApplicationKeyCredential` to automate the rolling of its expiring keys.

## EXAMPLES

### Example 1: Remove a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Remove-EntraApplicationKeyCredential -ApplicationId $application.Id -KeyId 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
```

This command removes the specified key credential from the specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-KeyId` Specifies a custom key ID. Use `Get-EntraApplicationKeyCredential` to get the keyId details.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplicationKeyCredential](Get-EntraApplicationKeyCredential.md)

[New-EntraApplicationKeyCredential](New-EntraApplicationKeyCredential.md)
