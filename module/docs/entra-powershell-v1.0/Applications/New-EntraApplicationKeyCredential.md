---
author: msewaweru
description: This article provides details on the New-EntraApplicationKeyCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Applications
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/New-EntraApplicationKeyCredential
schema: 2.0.0
title: New-EntraApplicationKeyCredential
---

# New-EntraApplicationKeyCredential

## SYNOPSIS

Creates a key credential for an application.

## SYNTAX

```powershell
New-EntraApplicationKeyCredential
 -ApplicationId <String>
 [-CustomKeyIdentifier <String>]
 [-Type <KeyType>]
 [-Usage <KeyUsage>]
 [-Value <String>]
 [-EndDate <DateTime>]
 [-StartDate <DateTime>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraApplicationKeyCredential` cmdlet creates a key credential for an application.

An application can use this command along with `Remove-EntraApplicationKeyCredential` to automate the rolling of its expiring keys.

As part of the request validation, proof of possession of an existing key is verified before the action can be performed.

## EXAMPLES

### Example 1: Create a new application key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$params = @{
    ApplicationId = $application.Id
    CustomKeyIdentifier = 'EntraPowerShellKey'
    StartDate = '2024-03-21T14:14:14Z'
    Type = 'Symmetric'
    Usage = 'Sign'
    Value = '<my-value>'
}
New-EntraApplicationKeyCredential @params
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

You can use the `Get-EntraApplication` cmdlet to retrieve the application Object ID.

### Example 2: Use a certificate to add an application key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 #create a new certificate object
$cer.Import('C:\Users\ContosoUser\appcert.cer') 
$bin = $cer.GetRawCertData()
$base64Value = [System.Convert]::ToBase64String($bin)
$bin = $cer.GetCertHash()
$base64Thumbprint = [System.Convert]::ToBase64String($bin)
$keyid = [System.Guid]::NewGuid().ToString() 

$params = @{
    ApplicationId = $application.Id
    CustomKeyIdentifier = $base64Thumbprint
    Type = 'AsymmetricX509Cert'
    Usage = 'Verify'
    Value = $base64Value
    StartDate = $cer.GetEffectiveDateString()
    EndDate = $cer.GetExpirationDateString()
}
New-EntraApplicationKeyCredential @params
```

This example shows how to create an application key credential.

- `-ApplicationId` Specifies a unique ID of an application
- `-CustomKeyIdentifier` Specifies a custom key ID.
- `-StartDate` Specifies the time when the key becomes valid as a DateTime object.
- `-EndDate` Specifies the time when the key becomes invalid as a DateTime object.
- `-Type` Specifies the type of the key.
- `-Usage` Specifies the key usage. for `AsymmetricX509Cert` the usage must be `Verify`and for `X509CertAndPassword` the usage must be `Sign`.
- `-Value` Specifies the value for the key.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplication](Get-EntraApplication.md)

[Get-EntraApplicationKeyCredential](Get-EntraApplicationKeyCredential.md)

[Remove-EntraApplicationKeyCredential](Remove-EntraApplicationKeyCredential.md)
