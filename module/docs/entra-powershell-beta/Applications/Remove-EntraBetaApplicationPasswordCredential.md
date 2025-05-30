---
title: Remove-EntraBetaApplicationPasswordCredential
description: This article provides details on the Remove-EntraBetaApplicationPasswordCredential command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationPasswordCredential

schema: 2.0.0
---

# Remove-EntraBetaApplicationPasswordCredential

## Synopsis

Removes a password credential from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationPasswordCredential
 -ApplicationId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationPasswordCredential` cmdlet removes a password credential from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an application password credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq 'Contoso Helpdesk Application'"
$applicationPassword = Get-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id | Where-Object {$_.DisplayName -eq 'ERP App Password'}
Remove-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id -KeyId $applicationPassword.KeyId
```

This example demonstrates how to remove the password credential for an application.

- `ApplicationId` Specifies the ID of the application. Use `Get-EntraBetaApplication` to get application ApplicationId value.
- `KeyId` Specifies the ID of the password credential. Use `Get-EntraBetaApplicationPasswordCredential` to retrieve a specific credential details.

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

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaApplicationPasswordCredential](Get-EntraBetaApplicationPasswordCredential.md)

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
