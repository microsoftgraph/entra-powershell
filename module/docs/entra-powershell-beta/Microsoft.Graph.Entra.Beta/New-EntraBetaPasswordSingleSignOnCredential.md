---
title: New-EntraBetaPasswordSingleSignOnCredential
description: This article provides details on the New-EntraBetaPasswordSingleSignOnCredential command.

ms.topic: reference
ms.date: 07/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaPasswordSingleSignOnCredential

schema: 2.0.0
---

# New-EntraBetaPasswordSingleSignOnCredential

## Synopsis

Creates the password Single-Sign-On (SSO) credentials.

## Syntax

```powershell
New-EntraBetaPasswordSingleSignOnCredential
 -ObjectId <String>
 -PasswordSSOCredential <PasswordSSOCredentials>
 [<CommonParameters>]
```

## Description

This cmdlet enables users to create their Password Single-Sign-On credentials for an application that they're part of. Specify `ObjectId` and `PasswordSSOCredential` parameters to create an SSO credentials.
Admin could create the group credentials as well.

## Examples

### Example 1: New password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Directory.ReadWrite.All'
$credentials = New-Object -TypeName Microsoft.Open.MSGraph.Model.PasswordSSOCredentials
$credentials.Id = '<user-or-group-Id>'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
$creds1 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId="param_emailOrUserName"; Value="foobar@ms.com"; Type="text"}
$creds2 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId="param_password"; Value="my-secret"; Type="password"}
$credentials.Credentials = @($creds1, $creds2)
$params = @{
    ObjectId = $servicePrincipal.Id
    PasswordSSOCredential = $credentials
}
New-EntraBetaPasswordSingleSignOnCredential @params
```

```Output
Id
--
cccccccc-2222-3333-4444-dddddddddddd
```

This example demonstrates how to create an password SSO credential for the given ObjectId and PasswordSSOObjectId.

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

### -PasswordSSOCredential

User or group ID.

```yaml
Type: System.PasswordSSOCredentials
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

### Microsoft.Online.Administration.PasswordSSOCredentials

## Notes

## Related links

[Set-EntraBetaPasswordSingleSignOnCredential](Set-EntraBetaPasswordSingleSignOnCredential.md)

[Get-EntraBetaPasswordSingleSignOnCredential](Get-EntraBetaPasswordSingleSignOnCredential.md)

[Remove-EntraBetaPasswordSingleSignOnCredential](Remove-EntraBetaPasswordSingleSignOnCredential.md)
