---
title:  Get-EntraServicePrincipalKeyCredential.
description: This article provides details on the  Get-EntraServicePrincipalKeyCredential Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalKeyCredential

schema: 2.0.0
---

# Get-EntraServicePrincipalKeyCredential

## Synopsis

Get key credentials for a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalKeyCredential 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Get-EntraServicePrincipalKeyCredential cmdlet gets the key credentials for a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the key credential of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalKeyCredential -ObjectId $ServicePrincipalId
```

```output
CustomKeyIdentifier DisplayName EndDateTime         Key KeyId                                StartDateTime       Type      Usage
------------------- ----------- -----------         --- -----                                -------------       ----      -----
                                08/02/2025 09:57:08     aaaaaaaa-0b0b-1c1c-2d2d-333333333333 08/02/2024 09:57:08 Symmetric Sign
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet.
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the key credential for the service principal identified by $ServicePrincipalId.

## Parameters

### -ObjectId

Specifies the ID of the application for which to get the password credential.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipalKeyCredential](New-EntraServicePrincipalKeyCredential.md)

[Remove-EntraServicePrincipalKeyCredential](Remove-EntraServicePrincipalKeyCredential.md)
