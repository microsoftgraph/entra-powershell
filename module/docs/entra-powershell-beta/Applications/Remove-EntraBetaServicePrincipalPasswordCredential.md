---
title: Remove-EntraBetaServicePrincipalPasswordCredential
description: This article provides details on the Remove-EntraBetaServicePrincipalPasswordCredential command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaServicePrincipalPasswordCredential

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalPasswordCredential

## Synopsis

Removes a password credential from a service principal.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalPasswordCredential
 -ServicePrincipalId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipalPasswordCredential` cmdlet removes a password credential from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Remove a password credential from a service principal in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$key = Get-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id
$key = $key | Where-Object {$_.DisplayName -eq 'My Password friendly name'}
Remove-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id -KeyId $key.KeyId
```

This example demonstrates how to remove a password credential from a service principal in Microsoft Entra ID.  

- `-ServicePrincipalId` parameter specifies the ObjectId of a specified Service Principal Password Credential.  
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

## Related Links

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalPasswordCredential](Get-EntraBetaServicePrincipalPasswordCredential.md)

[New-EntraBetaServicePrincipalPasswordCredential](New-EntraBetaServicePrincipalPasswordCredential.md)