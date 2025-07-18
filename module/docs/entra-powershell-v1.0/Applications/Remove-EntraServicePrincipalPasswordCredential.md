---
author: msewaweru
description: This article provides details on the Remove-EntraServicePrincipalPasswordCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 08/20/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraServicePrincipalPasswordCredential
schema: 2.0.0
title: Remove-EntraServicePrincipalPasswordCredential
---

# Remove-EntraServicePrincipalPasswordCredential

## SYNOPSIS

Removes a password credential from a service principal.

## SYNTAX

```powershell
Remove-EntraServicePrincipalPasswordCredential
 -ServicePrincipalId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraServicePrincipalPasswordCredential` cmdlet removes a password credential from a service principal in Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipalPasswordCredential](Get-EntraServicePrincipalPasswordCredential.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)
