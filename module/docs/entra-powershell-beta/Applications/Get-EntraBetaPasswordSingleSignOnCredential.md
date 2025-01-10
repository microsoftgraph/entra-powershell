---
title: Get-EntraBetaPasswordSingleSignOnCredential
description: This article provides details on the Get-EntraBetaPasswordSingleSignOnCredential command.

ms.topic: reference
ms.date: 07/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaPasswordSingleSignOnCredential

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
Connect-Entra -Scopes 'Application.ReadWrite.All','Directory.ReadWrite.All'
$servicePrincipal = Get-EntraBetaservicePrincipal -SearchString '<service-principal-name>'
$params = @{
    ObjectId = $servicePrincipal.Id
    PasswordSSOObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Get-EntraBetaPasswordSingleSignOnCredential @params
```

```Output
Id
--
cccccccc-2222-3333-4444-dddddddddddd
```

This example returns a password SSO credential for the given ObjectId and PasswordSSOObjectId.

- `PasswordSSOObjectId` parameter specifies the ID of the user or group this credential set belongs to.
- `ObjectId` parameter specifies the ID of a service principal. You can use `Get-EntraBetaservicePrincipal` cmdlet to get service principal object ID.

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

The ID of the user or group this credential set belongs to.

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
