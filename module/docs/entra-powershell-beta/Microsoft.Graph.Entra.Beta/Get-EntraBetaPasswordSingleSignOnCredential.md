---
title: Get-EntraBetaPasswordSingleSignOnCredential.
description: This article provides details on the Get-EntraBetaPasswordSingleSignOnCredential command.

ms.service: entra
ms.topic: reference
ms.date: 07/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPasswordSingleSignOnCredential

## Synopsis

Gets the password Single-Sign-On (SSO) credentials.

## Syntax

```powershell
Get-EntraBetaPasswordSingleSignOnCredential 
 -ObjectId <String> 
 -PasswordSSOObjectId <PasswordSSOObjectId>
 [<CommonParameters>]
```

## Description

This cmdlet enables users to read their Password Single-Sign-On credentials for an application that they're part of. Specify `ObjectId` and `PasswordSSOCredential` parameters for retrieve SSO credentials.
Admin could read the group credentials as well.
Note that the password field is hidden for security purpose.

## Examples

### Example 1: Get password single-sign-on credentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All and Directory.Read.All, Directory.ReadWrite.All'
$get_creds_output = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PasswordSSOObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id
--
cccccccc-2222-3333-4444-dddddddddddd
```

This command gets the password SSO credentials for the given ObjectId and PasswordSSOObjectId.

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

### Microsoft.Online.Administration.PasswordSSOCredentials

## Notes

## Related Links

[New-EntraBetaPasswordSingleSignOnCredential](New-EntraBetaPasswordSingleSignOnCredential.md)

[Set-EntraBetaPasswordSingleSignOnCredential](Set-EntraBetaPasswordSingleSignOnCredential.md)

[Remove-EntraBetaPasswordSingleSignOnCredential](Remove-EntraBetaPasswordSingleSignOnCredential.md)
