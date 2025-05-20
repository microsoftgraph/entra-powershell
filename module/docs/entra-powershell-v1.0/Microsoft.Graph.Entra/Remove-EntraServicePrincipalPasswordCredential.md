---
title: Remove-EntraServicePrincipalPasswordCredential
description: This article provides details on the Remove-EntraServicePrincipalPasswordCredential command.

ms.topic: reference
ms.date: 08/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipalPasswordCredential

schema: 2.0.0
---

# Remove-EntraServicePrincipalPasswordCredential

## Synopsis

Removes a password credential from a service principal.

## Syntax

```powershell
Remove-EntraServicePrincipalPasswordCredential
 -ServicePrincipalId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraServicePrincipalPasswordCredential` cmdlet removes a password credential from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Remove a password credential from a service principal in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$key = Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id
$key = $key | Where-Object {$_.DisplayName -eq 'Helpdesk secret'}
Remove-EntraServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id -KeyId $key.KeyId
```

This example demonstrates how to remove a password credential from a service principal in Microsoft Entra ID.  

- `-ServicePrincipalId` parameter specifies the ServicePrincipalId of a specified Service Principal Password Credential.  
- `-KeyId` parameter specifies the unique identifier of a Password Credential.

## Parameters

### -KeyId

Specifies the unique identifier of password credential.

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

### -ServicePrincipalId

Specifies the ID of an application in Microsoft Entra ID.

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

[Get-EntraServicePrincipalPasswordCredential](Get-EntraServicePrincipalPasswordCredential.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)
