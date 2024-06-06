---
title: Remove-EntraServicePrincipalKeyCredential.
description: This article provides details on the Remove-EntraServicePrincipalKeyCredential command.

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

# Remove-EntraServicePrincipalKeyCredential

## SYNOPSIS

Removes a key credential from a service principal.

## SYNTAX

```powershell
Remove-EntraServicePrincipalKeyCredential 
 -ObjectId <String> 
 -KeyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraServicePrincipalKeyCredential cmdlet removes a key credential from a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$SPObjectID = (Get-EntraServicePrincipal -SearchString 'Entra Multi-Factor Auth Client').ObjectID
Get-EntraServicePrincipalKeyCredential -ObjectId $SPObjectID
Remove-EntraServicePrincipalKeyCredential -ObjectID $SPObjectID -KeyId <PASTE_KEYID_VALUE>
```

This example demonstrates how to remove a key credential from a service principal in Microsoft Entra ID.

- First command stores the ObjectID of your service principal in the $SPObjectID variable.
- The second command gets all the Key Credentials for the service principal. Copy the preferred KeyID associated with the certificate to be removed and paste it at the <PASTE_KEYID_VALUE> in the third command.
- The last command removes the certificate (key credential) from the service principal configuration.

## PARAMETERS

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

### -ObjectId

Specifies the ID of a service principal.

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

[Get-EntraServicePrincipalKeyCredential](Get-EntraServicePrincipalKeyCredential.md)

[New-EntraServicePrincipalKeyCredential](New-EntraServicePrincipalKeyCredential.md)
