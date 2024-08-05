---
title: New-EntraBetaApplicationPassword
description: This article provides details on the New-EntraBetaApplicationPassword command.

ms.topic: reference
ms.date: 08/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplicationPassword

schema: 2.0.0
---

# New-EntraBetaApplicationPassword

## Synopsis

Adds a strong password to an application.

## Syntax

```powershell
New-EntraBetaApplicationPassword 
 -ObjectId <String> 
 -PasswordCredential <PasswordCredential>
 [<CommonParameters>]
```

## Description

Adds a strong password to an application.

## Examples

### Example 1: Add a password to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Directory.ReadWrite.All'
$PasswordCredential= New-Object Microsoft.Open.MSGraph.Model.PasswordCredential
$PasswordCredential.StartDateTime = Get-Date -Year 2024 -Month 12 -Day 28
$PasswordCredential.EndDateTime = Get-Date -Year 2025 -Month 2 -Day 28
$PasswordCredential.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes('a')
$PasswordCredential.Hint = 'b'
$PasswordCredential.DisplayName = 'test'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    PasswordCredential = $PasswordCredential
}
New-EntraBetaApplicationPassword @params
```

```Output
CustomKeyIdentifier DisplayName EndDateTime           Hint KeyId                                SecretText                               StartDateTime
------------------- ----------- -----------           ---- -----                                ----------                               -------------
{97}                test        2/28/2025 12:09:41 PM C57  aaaaaaaa-0b0b-1c1c-2d2d-333333333333 C578Q~hZEx7lu6TUFAilAMxu-5q6EioLPOFAUa66 12/28/2024 12:09:41 PM
```

This example adds a password to the specified application.

- `-ObjectId` parameter specifies the unique identifier of the application.
- `-PasswordCredential` parameter specifies a password credential associated with an application or a service principal.

## Parameters

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object.

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

## Related Links

[Remove-EntraBetaApplicationPassword](Remove-EntraBetaApplicationPassword.md)
