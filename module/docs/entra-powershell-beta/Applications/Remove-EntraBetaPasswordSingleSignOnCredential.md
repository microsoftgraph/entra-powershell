---
author: msewaweru
description: This article provides details on the Remove-EntraBetaPasswordSingleSignOnCredential command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/09/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Remove-EntraBetaPasswordSingleSignOnCredential
schema: 2.0.0
title: Remove-EntraBetaPasswordSingleSignOnCredential
---

# Remove-EntraBetaPasswordSingleSignOnCredential

## SYNOPSIS

Removes the password Single-Sign-On (SSO) credentials.

## SYNTAX

```powershell
Remove-EntraBetaPasswordSingleSignOnCredential
 -ServicePrincipalId <String>
 -PasswordSSOObjectId <PasswordSSOObjectId>
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet enables users to remove their Password Single-Sign-On credentials for an application that they're part of. Specify `ServicePrincipalId` and `PasswordSSOCredential` parameters to remove specific SSO credentials.
Admin could remove the group credentials as well.

## EXAMPLES

### Example 1: Remove password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.ReadWrite.All'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId $servicePrincipal.Id -PasswordSSOCredential 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This example removes the password SSO credentials for the given ServicePrincipalId and PasswordSSOObjectId.

- `-PasswordSSOObjectId` parameter specifies the User or Group ID.
- `-ServicePrincipalId` parameter specifies the object ID of a service principal.

## PARAMETERS

### -ServicePrincipalId

The unique identifier of the object specific Microsoft Entra ID object.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaPasswordSingleSignOnCredential](New-EntraBetaPasswordSingleSignOnCredential.md)

[Set-EntraBetaPasswordSingleSignOnCredential](Set-EntraBetaPasswordSingleSignOnCredential.md)

[Get-EntraBetaPasswordSingleSignOnCredential](Get-EntraBetaPasswordSingleSignOnCredential.md)
