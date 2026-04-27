---
title: Get-EntraApplicationKeyCredential
description: This article provides details on the Get-EntraApplicationKeyCredential command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationKeyCredential

schema: 2.0.0
---

# Get-EntraApplicationKeyCredential

## Synopsis

Gets the key credentials for an application.

## Syntax

```powershell
Get-EntraApplicationKeyCredential
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationKeyCredential` cmdlet retrieves the key credentials for an application. Specify `ObjectId` parameter to retrieve the key credentials for an application.

## Examples

### Example 1: Get key credentials

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraApplicationKeyCredential -ObjectId $application.ObjectId
```

```Output
CustomKeyIdentifier DisplayName     EndDateTime           Key KeyId                                StartDateTime         Type               Usage
------------------- -----------     -----------           --- -----                                -------------         ----               -----
{116, 101, 115, 116…} MyApp Cert 6/27/2024 11:49:17 AM     bbbbbbbb-1c1c-2d2d-3e3e-444444444444 6/27/2023 11:29:17 AM AsymmetricX509Cert Verify
```

This command gets the key credentials for the specified application.

`-ObjectId` parameter specifies the ID of an application object in Microsoft Entra ID.

## Parameters

### -ObjectId

Specifies a unique ID of an application in Microsoft Entra ID to retrieve key credentials. Use `Get-EntraApplication` for more details.

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

[New-EntraApplicationKeyCredential](New-EntraApplicationKeyCredential.md)

[Remove-EntraApplicationKeyCredential](Remove-EntraApplicationKeyCredential.md)
