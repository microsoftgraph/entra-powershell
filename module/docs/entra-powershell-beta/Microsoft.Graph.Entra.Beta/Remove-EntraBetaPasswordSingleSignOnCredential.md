---
title: Remove-EntraBetaPasswordSingleSignOnCredential
description: This article provides details on the Remove-EntraBetaPasswordSingleSignOnCredential command.

ms.topic: reference
ms.date: 07/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaPasswordSingleSignOnCredential

schema: 2.0.0
---

# Remove-EntraBetaPasswordSingleSignOnCredential

## Synopsis

Removes the password Single-Sign-On (SSO) credentials.

## Syntax

```powershell
Remove-EntraBetaPasswordSingleSignOnCredential
 -ObjectId <String>
 -PasswordSSOObjectId <PasswordSSOObjectId>
 [<CommonParameters>]
```

## Description

This cmdlet enables users to remove their Password Single-Sign-On credentials for an application that they're part of. Specify `ObjectId` and `PasswordSSOCredential` parameters to remove specific SSO credentials.
Admin could remove the group credentials as well.

## Examples

### Example 1: Remove password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.ReadWrite.All'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
$params = @{
    ObjectId = $servicePrincipal.Id 
    PasswordSSOCredential = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Remove-EntraBetaPasswordSingleSignOnCredential @params
```

This example removes the password SSO credentials for the given ObjectId and PasswordSSOObjectId.

- `-PasswordSSOObjectId` parameter specifies the User or Group ID.
- `-ObjectId` parameter specifies the object ID of a service principal.

## Parameters

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object.

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

### -PasswordSSOObjectId

User or group ID.

```yaml
Type: System.PasswordSSOObjectId
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

## Related links

[New-EntraBetaPasswordSingleSignOnCredential](New-EntraBetaPasswordSingleSignOnCredential.md)

[Set-EntraBetaPasswordSingleSignOnCredential](Set-EntraBetaPasswordSingleSignOnCredential.md)

[Get-EntraBetaPasswordSingleSignOnCredential](Get-EntraBetaPasswordSingleSignOnCredential.md)
