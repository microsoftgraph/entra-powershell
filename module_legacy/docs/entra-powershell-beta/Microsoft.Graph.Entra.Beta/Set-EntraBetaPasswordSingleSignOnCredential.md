---
title: Set-EntraBetaPasswordSingleSignOnCredential
description: This article provides details on the Set-EntraBetaPasswordSingleSignOnCredential command.

ms.topic: reference
ms.date: 07/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaPasswordSingleSignOnCredential

schema: 2.0.0
---

# Set-EntraBetaPasswordSingleSignOnCredential

## Synopsis

Sets the password Single-Sign-On (SSO) credentials.

## Syntax

```powershell
Set-EntraBetaPasswordSingleSignOnCredential
 -ObjectId <String>
 -PasswordSSOCredential <PasswordSSOCredentials>
 [<CommonParameters>]
```

## Description

This cmdlet enables users to set their Password Single-Sign-On credentials for an application that they're part of. Specify `ObjectId` and `PasswordSSOCredential` parameters to updates SSO credentials.
Admin could set the group credentials as well.

## Examples

### Example 1: Set password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Directory.ReadWrite.All'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
$credentials = New-Object -TypeName Microsoft.Open.MSGraph.Model.PasswordSSOCredentials
$credentials.Id = '<user-or-group-Id>'
$creds1 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId="param_emailOrUserName"; Value="foobar@ms.com"; Type="text"}
$creds2 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId="param_password"; Value="my-secret"; Type="password"}
$credentials.Credentials = @($creds1, $creds2)
$params = @{
    ObjectId = $servicePrincipal.Id
    PasswordSSOCredential = $credentials
}
Set-EntraBetaPasswordSingleSignOnCredential @params
```

This example demonstrates how to set the password SSO credentials for the given ObjectId and PasswordSSOObjectId.

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

## Notes

## Related Links

[New-EntraBetaPasswordSingleSignOnCredential](New-EntraBetaPasswordSingleSignOnCredential.md)

[Get-EntraBetaPasswordSingleSignOnCredential](Get-EntraBetaPasswordSingleSignOnCredential.md)

[Remove-EntraBetaPasswordSingleSignOnCredential](Remove-EntraBetaPasswordSingleSignOnCredential.md)
