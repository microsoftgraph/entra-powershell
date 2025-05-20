---
title: Get-EntraServicePrincipalPasswordCredential
description: This article provides details on the  Get-EntraServicePrincipalPasswordCredential Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalPasswordCredential

schema: 2.0.0
---

# Get-EntraServicePrincipalPasswordCredential

## Synopsis

Get credentials for a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalPasswordCredential
 -ServicePrincipalId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalPasswordCredential` cmdlet gets the password credentials for a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the password credential of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id
```

```Output
CustomKeyIdentifier DisplayName EndDateTime         Hint KeyId                                SecretText StartDateTime
------------------- ----------- -----------         ---- -----                                ---------- -------------
                                17-04-2025 07:32:41 gjW  bdf6a3df-cc9b-4612-b948-e32804ee88f7            17-04-2024 07:32:41
                                21-03-2025 08:12:08 4fl  7f4414ec-8f72-49a8-b949-70d635899656            21-03-2024 08:12:08
                                12-12-2024 08:39:07 mjl  0fff6b21-0a20-4f7c-93ba-26ed9b648344            12-12-2023 08:39:10
```

This example retrieves the password credentials for specified service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the object ID of a service principal. You can use the command `Get-EntraServicePrincipal` to get a service principal Id.

## Parameters

### -ServicePrincipalId

Specifies the ID of the service principal for which to get password credentials.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)

[Remove-EntraServicePrincipalPasswordCredential](Remove-EntraServicePrincipalPasswordCredential.md)
