---
author: msewaweru
description: This article provides details on the New-EntraServicePrincipalKeyCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraServicePrincipalKeyCredential
schema: 2.0.0
title: New-EntraServicePrincipalKeyCredential
---

# New-EntraServicePrincipalKeyCredential

## SYNOPSIS

Creates a password credential for a service principal.

## SYNTAX

```powershell
New-EntraServicePrincipalKeyCredential
 -ObjectId <String>
 [-CustomKeyIdentifier <String>]
 [-StartDate <DateTime>]
 [-EndDate <DateTime>]
 [-Type <KeyType>]
 [-Usage <KeyUsage>]
 [-Value <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The New-EntraServicePrincipalKeyCredential cmdlet creates a key credential for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a key credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraServicePrincipalKeyCredential 
```

This command creates a key credential for a service principal.

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

### -ObjectId

Specifies an object ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipalKeyCredential](Get-EntraServicePrincipalKeyCredential.md)

[Remove-EntraServicePrincipalKeyCredential](Remove-EntraServicePrincipalKeyCredential.md)
