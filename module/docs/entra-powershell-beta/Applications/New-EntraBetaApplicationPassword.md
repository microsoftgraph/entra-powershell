---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationPassword command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/02/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaApplicationPassword
schema: 2.0.0
title: New-EntraBetaApplicationPassword
---

# New-EntraBetaApplicationPassword

## Synopsis

Adds a strong password to an application.

## Syntax

```powershell
New-EntraBetaApplicationPassword
 -ApplicationId <String>
 -PasswordCredential <PasswordCredential>
 [<CommonParameters>]
```

## Description

Adds a strong password to an application.

## Examples

### Example 1: Add a password to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$passwordCredential = New-Object Microsoft.Open.MSGraph.Model.PasswordCredential
$passwordCredential.StartDateTime = Get-Date -Year 2024 -Month 10 -Day 23
$passwordCredential.EndDateTime = Get-Date -Year 2025 -Month 2 -Day 28
$passwordCredential.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes('ERP App Password')
$passwordCredential.Hint = 'erpapppassword'
$passwordCredential.DisplayName = 'ERP App Password'
New-EntraBetaApplicationPassword -ApplicationId $application.Id -PasswordCredential $passwordCredential
```

```Output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                               StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                               -------------
{97}                            2/28/2025 7:05:39 AM nnW  bbbbbbbb-1c1c-2d2d-3e3e-444444444444 <my-secret-text> 12/28/2024 7:05:39 AM
```

This example adds a password to the specified application.

- `-ApplicationId` parameter specifies the unique identifier of the application.
- `-PasswordCredential` parameter specifies a password credential associated with an application or a service principal.

## Parameters

### -ApplicationId

The unique identifier of the application object.

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

### -PasswordCredential

Represents a password credential associated with an application or a service principal.

```yaml
Type: PasswordCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String

### Microsoft.Open.MSGraph.Model.PasswordCredential

## Outputs

## Notes

## Related links

[Remove-EntraBetaApplicationPassword](Remove-EntraBetaApplicationPassword.md)
