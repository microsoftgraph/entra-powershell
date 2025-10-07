---
author: msewaweru
description: This article provides details on the Set-EntraBetaPasswordSingleSignOnCredential command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/09/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Set-EntraBetaPasswordSingleSignOnCredential
schema: 2.0.0
title: Set-EntraBetaPasswordSingleSignOnCredential
---

# Set-EntraBetaPasswordSingleSignOnCredential

## SYNOPSIS

Sets the password Single-Sign-On (SSO) credentials.

## SYNTAX

```powershell
Set-EntraBetaPasswordSingleSignOnCredential
 -ServicePrincipalId <String>
 -PasswordSSOCredential <PasswordSSOCredentials>
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet enables users to set their Password Single-Sign-On credentials for an application that they're part of. Specify `ServicePrincipalId` and `PasswordSSOCredential` parameters to updates SSO credentials.
Admin could set the group credentials as well.

## EXAMPLES

### Example 1: Set password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.ReadWrite.All'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
$credentials = New-Object -TypeName Microsoft.Open.MSGraph.Model.PasswordSSOCredentials
$credentials.Id = '<user-or-group-Id>'
$creds1 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId = "param_emailOrUserName"; Value = "foobar@ms.com"; Type = "text" }
$creds2 = [Microsoft.Open.MSGraph.Model.PasswordSSOCredential]@{FieldId = "param_password"; Value = "my-secret"; Type = "password" }
$credentials.Credentials = @($creds1, $creds2)

Set-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId $servicePrincipal.Id -PasswordSSOCredential $credentials
```

This example demonstrates how to set the password SSO credentials for the given ServicePrincipalId and PasswordSSOObjectId.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaPasswordSingleSignOnCredential](New-EntraBetaPasswordSingleSignOnCredential.md)

[Get-EntraBetaPasswordSingleSignOnCredential](Get-EntraBetaPasswordSingleSignOnCredential.md)

[Remove-EntraBetaPasswordSingleSignOnCredential](Remove-EntraBetaPasswordSingleSignOnCredential.md)
