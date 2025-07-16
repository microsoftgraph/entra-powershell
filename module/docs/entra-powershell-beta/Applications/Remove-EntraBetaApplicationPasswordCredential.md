---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationPasswordCredential command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationPasswordCredential
schema: 2.0.0
title: Remove-EntraBetaApplicationPasswordCredential
---

# Remove-EntraBetaApplicationPasswordCredential

## SYNOPSIS

Removes a password credential from an application.

## SYNTAX

```powershell
Remove-EntraBetaApplicationPasswordCredential
 -ApplicationId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplicationPasswordCredential` cmdlet removes a password credential from an application in Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaApplicationPasswordCredential](Get-EntraBetaApplicationPasswordCredential.md)

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
