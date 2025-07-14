---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationKey command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaApplicationKey
schema: 2.0.0
title: New-EntraBetaApplicationKey
---

# New-EntraBetaApplicationKey

## SYNOPSIS

Adds a new key to an application.

## SYNTAX

```powershell
New-EntraBetaApplicationKey
 -ApplicationId <String>
 -KeyCredential <KeyCredential>
 -Proof <String>
 [-PasswordCredential <PasswordCredential>]
 [<CommonParameters>]
```

## DESCRIPTION

Adds a new key to an application.

## EXAMPLES

### Example 1: Add a key credential to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Application.ReadWrite.OwnedBy'
$app = Get-EntraBetaApplication -Filter "DisplayName eq '<application-display-name>'"
$params = @{
    ApplicationId      = $app.Id
    KeyCredential      = @{ key = [System.Convert]::FromBase64String('{base64cert}') }
    PasswordCredential = @{ DisplayName = 'mypassword' }
    Proof              = '{token}'
}
New-EntraBetaApplicationKey @params
```

This command adds a key credential to an specified application.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-KeyCredential` parameter specifies the application key credential to add.
- `-PasswordCredential` parameter specifies the application password credential to add.
- `-Proof` parameter specifies the signed JWT token used as a proof of possession of the existing keys.

## PARAMETERS

### -KeyCredential

The application key credential to add.

NOTES: keyId value should be null.

```yaml
Type: KeyCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

The application password credential to add.

NOTES: keyId value should be null.

```yaml
Type: PasswordCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proof

A signed JWT token used as a proof of possession of the existing keys.

```yaml
Type: System.String
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

## INPUTS

### String

### Microsoft.Open.MSGraph.Model.KeyCredential

### Microsoft.Open.MSGraph.Model.PasswordCredential

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaApplicationKey](Remove-EntraBetaApplicationKey.md)
