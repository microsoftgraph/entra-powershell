---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationPassword command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/02/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationPassword
schema: 2.0.0
title: Remove-EntraBetaApplicationPassword
---

# Remove-EntraBetaApplicationPassword

## SYNOPSIS

Remove a password from an application.

## SYNTAX

```powershell
Remove-EntraBetaApplicationPassword
 -ApplicationId <String>
 [-KeyId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Remove a password from an application.

## EXAMPLES

### Example 1: Removes a password from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$applicationPassword = Get-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id | Where-Object { $_.DisplayName -eq 'ERP App Password' }
Remove-EntraBetaApplicationPassword -ApplicationId $application.Id -KeyId $applicationPassword.KeyId
```

This example removes the specified password from the specified application.

- `-ApplicationId` parameter specifies the unique identifier of the application.
- `-KeyId` parameter specifies the unique identifier of the PasswordCredential.

## PARAMETERS

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

## INPUTS

### String

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationPassword](New-EntraBetaApplicationPassword.md)
