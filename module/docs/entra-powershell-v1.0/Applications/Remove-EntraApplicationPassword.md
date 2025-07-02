---
author: msewaweru
description: This article provides details on the Remove-EntraApplicationPassword command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationPassword
schema: 2.0.0
title: Remove-EntraApplicationPassword
---

# Remove-EntraApplicationPassword

## Synopsis

Remove a password from an application.

## Syntax

```powershell
Remove-EntraApplicationPassword
 -ApplicationId <String>
 [-KeyId <String>]
 [<CommonParameters>]
```

## Description

Remove a password from an application.

## Examples

### Example 1: Removes a password from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$applicationPassword = Get-EntraApplicationPasswordCredential -ApplicationId $application.Id | Where-Object {$_.DisplayName -eq 'CRM Helpdesk App'}
Remove-EntraApplicationPassword -ApplicationId $application.Id -KeyId $applicationPassword.KeyId
```

This example removes the specified password from the specified application.

- `-ApplicationId` parameter specifies the unique identifier of the application.
- `-KeyId` parameter specifies the unique identifier of the PasswordCredential.

## Parameters

### -ApplicationId

The unique identifier of the application.

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

The unique identifier for the key.

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

[New-EntraApplicationPassword](New-EntraApplicationPassword.md)
