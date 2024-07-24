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
online version:
schema: 2.0.0
---

# New-EntraBetaApplicationKeyCredential

## Synopsis

Creates a key credential for an application.

## Syntax

```powershell
New-EntraBetaApplicationKeyCredential 
 -ObjectId <String>
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
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission

$AppId = (Get-EntraApplication -Top 1).Objectid
$params = @{
    ObjectId = $AppId
    CustomKeyIdentifier = 'EntraPowerShellKey'
    StartDate = '11/7/2016'
    Type = 'Symmetric'
    Usage = 'Sign'
    Value = '<my-value>'
}

New-EntraBetaApplicationKeyCredential @params
```

```Output
CustomKeyIdentifier : {84, 101, 115, 116}
EndDate             : 11/7/2017 12:00:00 AM
KeyId               : aaaaaaaa-0b0b-1c1c-2d2d-333333333333
StartDate           : 11/7/2016 12:00:00 AM
Type                : Symmetric
Usage               : Sign
Value               : {49, 50, 51}
```

This example shows how to create an application key credential.

You can use the `Get-EntraApplication` cmdlet to retrieve the application Object ID.

### Example 2: Use a certificate to add an application key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission

$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 #create a new certificate object
$cer.Import('C:\Users\PFuller\Desktop\abc.cer') 
$bin = $cer.GetRawCertData()
$base64Value = [System.Convert]::ToBase64String($bin)
$bin = $cer.GetCertHash()
$base64Thumbprint = [System.Convert]::ToBase64String($bin)
$keyid = [System.Guid]::NewGuid().ToString() 

$params = @{
    ObjectId = '22223333-cccc-4444-dddd-5555eeee6666'
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

### -ObjectId

Specifies a unique ID of an application in Microsoft Entra ID.

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
