---
title: Remove-EntraApplicationPassword
description: This article provides details on the Remove-EntraApplicationPassword command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraApplicationPassword

schema: 2.0.0
---

# Remove-EntraApplicationPassword

## Synopsis

Remove a password from an application.

## Syntax

```powershell
Remove-EntraApplicationPassword
 -ObjectId <String>
 [-KeyId <String>]
 [<CommonParameters>]
```

## Description

Remove a password from an application.

## Examples

### Example 1: Removes a password from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq '<Application-DisplayName>'"
$params = @{
    ObjectId = $application.Id
    KeyId = 'cccccccc-2d2d-3e3e-4f4f-555555555555'
}

Remove-EntraApplicationPassword @params
```

This example removes the specified password from the specified application.

- `-ObjectId` parameter specifies the unique identifier of the application.
- `-KeyId` parameter specifies the unique identifier of the PasswordCredential.

## Parameters

### -ObjectId

The unique identifier of the application.

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

## Inputs

### String

## Outputs

## Notes

## Related links

[New-EntraApplicationPassword](New-EntraApplicationPassword.md)
