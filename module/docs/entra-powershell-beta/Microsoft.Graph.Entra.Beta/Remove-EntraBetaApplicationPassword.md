---
title: Remove-EntraBetaApplicationPassword
description: This article provides details on the Remove-EntraBetaApplicationPassword command.

ms.topic: reference
ms.date: 08/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaApplicationPassword

schema: 2.0.0
---

# Remove-EntraBetaApplicationPassword

## Synopsis

Remove a password from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationPassword
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
$application = Get-EntraBetaApplication -Filter "DisplayName eq '<Application-DisplayName>'"
$params = @{
    ObjectId = $application.Id
    KeyId = 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
}
Remove-EntraBetaApplicationPassWord @params
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

## Related Links

[New-EntraBetaApplicationPassword](New-EntraBetaApplicationPassword.md)
