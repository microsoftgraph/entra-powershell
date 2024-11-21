---
title: New-EntraBetaApplicationKeyCredential
description: This article provides details on the New-EntraBetaApplicationKeyCredential command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplicationKeyCredential

schema: 2.0.0
---

# New-EntraBetaApplicationKeyCredential

## Synopsis

Creates a key credential for an application.

## Syntax

```powershell
New-EntraBetaApplicationKeyCredential
 -ApplicationId <String>
 [-CustomKeyIdentifier <String>]
 [-Type <KeyType>]
 [-Usage <KeyUsage>]
 [-Value <String>]
 [-EndDate <DateTime>]
 [-StartDate <DateTime>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaApplicationKeyCredential` cmdlet creates a key credential for an application.

An application can use this command along with `Remove-EntraBetaApplicationKeyCredential` to automate the rolling of its expiring keys.

As part of the request validation, proof of possession of an existing key is verified before the action can be performed.

## Examples

### Example 1: Create a new application key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'

$AppId = (Get-EntraApplication -Top 1).Objectid
$params = @{
    ApplicationId = $AppId
    CustomKeyIdentifier = 'EntraPowerShellKey'
    StartDate = '2024-03-21T14:14:14Z'
    Type = 'Symmetric'
    Usage = 'Sign'
    Value = '<my-value>'
}

New-EntraBetaApplicationKeyCredential @params
```

```Output
CustomKeyIdentifier : {84, 101, 115, 116}
EndDate             : 2024-03-21T14:14:14Z
KeyId               : aaaaaaaa-0b0b-1c1c-2d2d-333333333333
StartDate           : 2025-03-21T14:14:14Z
Type                : Symmetric
Usage               : Sign
Value               : {49, 50, 51}
```

This example shows how to create an application key credential.

- `-ApplicationId` Specifies a unique ID of an application
- `-CustomKeyIdentifier` Specifies a custom key ID.
- `-StartDate` Specifies the time when the key becomes valid as a DateTime object.
- `-Type` Specifies the type of the key.
- `-Usage` Specifies the key usage. for `AsymmetricX509Cert` the usage must be `Verify`and for `X509CertAndPassword` the usage must be `Sign`.
- `-Value` Specifies the value for the key.

You can use the `Get-EntraBetaApplication` cmdlet to retrieve the application Object ID.

### Example 2: Use a certificate to add an application key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'

$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 #create a new certificate object
$cer.Import('C:\Users\ContosoUser\appcert.cer') 
$bin = $cer.GetRawCertData()
$base64Value = [System.Convert]::ToBase64String($bin)
$bin = $cer.GetCertHash()
$base64Thumbprint = [System.Convert]::ToBase64String($bin)
$keyid = [System.Guid]::NewGuid().ToString() 

$params = @{
    ApplicationId = '22223333-cccc-4444-dddd-5555eeee6666'
    CustomKeyIdentifier = $base64Thumbprint
    Type = 'AsymmetricX509Cert'
    Usage = 'Verify'
    Value = $base64Value
    StartDate = $cer.GetEffectiveDateString()
    EndDate = $cer.GetExpirationDateString()
}

New-EntraBetaApplicationKeyCredential @params
```

This example shows how to create an application key credential.

- `-ApplicationId` Specifies a unique ID of an application
- `-CustomKeyIdentifier` Specifies a custom key ID.
- `-StartDate` Specifies the time when the key becomes valid as a DateTime object.
- `-EndDate` Specifies the time when the key becomes invalid as a DateTime object.
- `-Type` Specifies the type of the key.
- `-Usage` Specifies the key usage. for `AsymmetricX509Cert` the usage must be `Verify`and for `X509CertAndPassword` the usage must be `Sign`.
- `-Value` Specifies the value for the key.

## Parameters

### -CustomKeyIdentifier

Specifies a custom key ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -EndDate

Specifies the time when the key becomes invalid as a DateTime object.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ApplicationId

Specifies a unique ID of an application in Microsoft Entra ID.

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

### -StartDate

Specifies the time when the key becomes valid as a DateTime object.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Type

Specifies the type of the key.

```yaml
Type: KeyType
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Usage

Specifies the key usage.

- `AsymmetricX509Cert`: The usage must be `Verify`.
- `X509CertAndPassword`: The usage must be `Sign`.

```yaml
Type: KeyUsage
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Value

Specifies the value for the key.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaApplicationKeyCredential](Get-EntraBetaApplicationKeyCredential.md)

[Remove-EntraBetaApplicationKeyCredential](Remove-EntraBetaApplicationKeyCredential.md)
