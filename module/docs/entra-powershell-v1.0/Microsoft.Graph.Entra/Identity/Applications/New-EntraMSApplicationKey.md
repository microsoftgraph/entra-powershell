---
title: New-EntraMSApplicationKey
description: This article provides details on the New-EntraMSApplicationKey command.

ms.service: entra
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSApplicationKey

## Synopsis
Adds a new key to an application.

## Syntax

```powershell
New-EntraMSApplicationKey 
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
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission

$params = @{
    ObjectId = 'cccccccc-8888-9999-0000-dddddddddddd'
    KeyCredential = @{ key=[System.Convert]::FromBase64String("{base64cert}") }
    PasswordCredential = @{ DisplayName = 'mypassword' }
    Proof = "{token}"
}

New-EntraMSApplicationKey @params
```

This command adds a key credential the specified application.

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

The unique identifier of the object specific Microsoft Entra ID object

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

## Related LINKS

[Remove-EntraMSApplicationKey](Remove-EntraMSApplicationKey.md)
