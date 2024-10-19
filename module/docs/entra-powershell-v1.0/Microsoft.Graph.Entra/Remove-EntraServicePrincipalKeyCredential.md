---
title: Remove-EntraServicePrincipalKeyCredential
description: This article provides details on the Remove-EntraServicePrincipalKeyCredential command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipalKeyCredential

schema: 2.0.0
---

# Remove-EntraServicePrincipalKeyCredential

## Synopsis

Removes a key credential from a service principal.

## Syntax

```powershell
Remove-EntraServicePrincipalKeyCredential
 -ServicePrincipalId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The Remove-EntraServicePrincipalKeyCredential cmdlet removes a key credential from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Remove a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$SPObjectID = (Get-EntraServicePrincipal -SearchString 'Entra Multi-Factor Auth Client').ObjectID
Get-EntraServicePrincipalKeyCredential -ServicePrincipalId $SPObjectID
Remove-EntraServicePrincipalKeyCredential -ServicePrincipalId $SPObjectID -KeyId <PASTE_KEYID_VALUE>
```

This example demonstrates how to remove a key credential from a service principal in Microsoft Entra ID.

- First command stores the ObjectID of your service principal in the $SPObjectID variable.
- The second command gets all the Key Credentials for the service principal. Copy the preferred KeyID associated with the certificate to be removed and paste it at the <PASTE_KEYID_VALUE> in the third command.
- The last command removes the certificate (key credential) from the service principal configuration.

## Parameters

### -KeyId

Specifies the ID of a key credential.

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

Specifies the ID of a service principal.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipalKeyCredential](Get-EntraServicePrincipalKeyCredential.md)

[New-EntraServicePrincipalKeyCredential](New-EntraServicePrincipalKeyCredential.md)
