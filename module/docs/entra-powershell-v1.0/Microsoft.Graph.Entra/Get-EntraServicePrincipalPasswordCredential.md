---
title:  Get-EntraServicePrincipalPasswordCredential.
description: This article provides details on the  Get-EntraServicePrincipalPasswordCredential Command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipalPasswordCredential

## SYNOPSIS

Get credentials for a service principal.

## SYNTAX

```powershell
Get-EntraServicePrincipalPasswordCredential 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraServicePrincipalPasswordCredential cmdlet gets the password credentials for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the password credential of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalPasswordCredential -ObjectId $ServicePrincipalId
```

```output
CustomKeyIdentifier DisplayName EndDateTime         Hint KeyId                                SecretText StartDateTime
------------------- ----------- -----------         ---- -----                                ---------- -------------
                                21/03/2025 08:12:08 333  aaaaaaaa-0b0b-1c1c-2d2d-333333333333            21/03/2024 08:12:08
                                12/12/2024 08:39:07 444  bbbbbbbb-1c1c-2d2d-3e3e-444444444444            12/12/2023 08:39:10
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the password credential of a service principal identified by $ServicePrincipalId.

## PARAMETERS

### -ObjectId

Specifies the ID of the service principal for which to get password credentials.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)

[Remove-EntraServicePrincipalPasswordCredential](Remove-EntraServicePrincipalPasswordCredential.md)
