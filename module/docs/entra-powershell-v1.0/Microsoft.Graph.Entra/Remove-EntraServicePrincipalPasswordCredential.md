---
title: Get-EntraBetaAuditSignInLogs.
description: This article provides details on the Get-EntraBetaAuditSignInLogs command.

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

# Remove-EntraServicePrincipalPasswordCredential

## SYNOPSIS

Removes a password credential from a service principal.

## SYNTAX

```powershell
Remove-EntraServicePrincipalPasswordCredential
 -ObjectId <String>
 -KeyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraServicePrincipalPasswordCredential cmdlet removes a password credential from a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
Remove-AzureADServicePrincipalPasswordCredential -ObjectID '00001111-aaaa-2222-bbbb-3333cccc4444' -KeyId 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
```

This command demonstrates how to remove a password credential from a service principal in Microsoft Entra ID.  

- **ObjectId**: The ObjectId of the specified Service Principal Password Credential.  
- **KeyID**: The unique identifier of the Password Credential.  

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

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

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

[Get-EntraServicePrincipalPasswordCredential](Get-EntraServicePrincipalPasswordCredential.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)
