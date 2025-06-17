---
title: Remove-EntraApplicationPasswordCredential
description: This article provides details on the Remove-EntraApplicationPasswordCredential command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Applications-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationPasswordCredential

schema: 2.0.0
---

# Remove-EntraApplicationPasswordCredential

## Synopsis

Removes a password credential from an application.

## Syntax

```powershell
Remove-EntraApplicationPasswordCredential
 -ApplicationId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraApplicationPasswordCredential` cmdlet removes a password credential from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an application password credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "displayName eq 'Contoso Helpdesk Application'"
$applicationPassword = Get-EntraApplicationPasswordCredential -ApplicationId $application.Id | Where-Object {$_.DisplayName -eq 'ERP App Password'}
Remove-EntraApplicationPasswordCredential -ApplicationId $application.Id -KeyId $applicationPassword.KeyId
```

This example demonstrates how to remove the password credential for an application.

- `ApplicationId` Specifies the ID of the application. Use `Get-EntraApplication` to get application ObjectId value.
- `KeyId` Specifies the ID of the password credential. Use `Get-EntraApplicationPasswordCredential` to retrieve a specific credential details.

## Parameters

### -KeyId

Specifies the ID of the password credential.

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

Specifies the ID of the application in Microsoft Entra ID.

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

[Get-EntraApplication](Get-EntraApplication.md)

[Get-EntraApplicationPasswordCredential](Get-EntraApplicationPasswordCredential.md)

[Remove-EntraApplicationPasswordCredential](Remove-EntraApplicationPasswordCredential.md)
