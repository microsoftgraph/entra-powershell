---
title: New-EntraApplicationKey
description: This article provides details on the New-EntraApplicationKey command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraApplicationKey

schema: 2.0.0
---

# New-EntraApplicationKey

## Synopsis

Adds a new key to an application.

## Syntax

```powershell
New-EntraApplicationKey
 -ObjectId <String>
 -KeyCredential <KeyCredential>
 -PasswordCredential <PasswordCredential>]
 -Proof <String>
 [<CommonParameters>]
```

## Description

Adds a new key to an application.

## Examples

### Example 1: Add a key credential to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$app = Get-EntraApplication -Filter "DisplayName eq '<application-display-name>'"
$params = @{
    ObjectId = $app.ObjectId
    KeyCredential = @{ key=[System.Convert]::FromBase64String('{base64cert}') }
    PasswordCredential = @{ DisplayName = 'mypassword' }
    Proof = '{token}'
}

New-EntraApplicationKey @params
```

This command adds a key credential to an specified application.

- `-ObjectId` parameter specifies the unique identifier of an application.
- `-KeyCredential` parameter specifies the application key credential to add.
- `-PasswordCredential` parameter specifies the application password credential to add.
- `-Proof` parameter specifies the signed JWT token used as a proof of possession of the existing keys.

## Parameters

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

### -ObjectId

The unique identifier of the application object.

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

## Inputs

### String

### Microsoft.Open.MSGraph.Model.KeyCredential

### Microsoft.Open.MSGraph.Model.PasswordCredential

## Outputs

### Microsoft.Open.MSGraph.Model.KeyCredential

## Notes

## Related Links

[Remove-EntraApplicationKey](Remove-EntraApplicationKey.md)
