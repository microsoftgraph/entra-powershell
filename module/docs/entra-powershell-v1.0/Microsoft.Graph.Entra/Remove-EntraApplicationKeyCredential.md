---
title: Remove-EntraApplicationKeyCredential.
description: This article provides details on the Remove-EntraApplicationKeyCredential command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationKeyCredential

## Synopsis

Removes a key credential from an application.

## Syntax

```powershell
Remove-EntraApplicationKeyCredential
 -ObjectId <String> 
 -KeyId <String> 
 [<CommonParameters>]
```

## Description

The `Remove-EntraApplicationKeyCredential` cmdlet removes a key credential from an application.

An application can use this command along with `New-EntraApplicationKeyCredential` to automate the rolling of its expiring keys.

## Examples

### Example 1: Remove a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission

$params = @{
    ObjectId = '33334444-dddd-5555-eeee-6666ffff7777'
    KeyId = 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
}

Remove-EntraApplicationKeyCredential @params
```

This command removes the specified key credential from the specified application.

## Parameters

### -KeyId

Specifies a custom key ID.

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

### -ObjectId

Specifies a unique ID of an application in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraApplicationKeyCredential](Get-EntraApplicationKeyCredential.md)

[New-EntraApplicationKeyCredential](New-EntraApplicationKeyCredential.md)
