---
title: Get-EntraBetaTrustFrameworkPolicy
description: This article provides details on the Get-EntraBetaTrustFrameworkPolicy command.


ms.topic: reference
ms.date: 08/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaTrustFrameworkPolicy

schema: 2.0.0
---

# Get-EntraBetaTrustFrameworkPolicy

## Synopsis

Retrieves the created trust framework policies (custom policies) in the directory.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaTrustFrameworkPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaTrustFrameworkPolicy
 -Id <String>
 [-OutputFilePath <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaTrustFrameworkPolicy` cmdlet retrieves the trust framework policies that have been created in the directory.

## Examples

### Example 1: Retrieves the list of all trust framework policies in the directory

```powershell
Connect-Entra -Scopes 'Policy.Read.All', 'Policy.ReadWrite.TrustFramework'
Get-EntraBetaTrustFrameworkPolicy
```

```Output                                             Id                                                                                                               ---                                              B2C_1A_SIGNUP_SIGNIN                                                                                             B2C_1A_TRUSTFRAMEWORKBASE
B2C_1A_TRUSTFRAMEWORKEXTENSIONS
```

This example retrieves the list of all trust framework policies in the directory.

### Example 2: Retrieves the contents of the specified trust framework policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All', 'Policy.ReadWrite.TrustFramework'
$params = @{
    Id = 'B2C_1A_SIGNUP_SIGNIN'
}
Get-EntraBetaTrustFrameworkPolicy @params
```

This example retrieves the contents of the specified trust framework policy.

The contents of received trust framework policy are displayed on screen.

- `-Id` Parameter specifies ID for a trust framework policy.

### Example 3: Retrieves the contents of the specified trust framework policy on specific output file path

```powershell
Connect-Entra -Scopes 'Policy.Read.All', 'Policy.ReadWrite.TrustFramework'
$params = @{
    Id = 'B2C_1A_SIGNUP_SIGNIN'
    OutputFilePath = 'C:\RetrivedPolicy.xml'
}
Get-EntraBetaTrustFrameworkPolicy @params
```

This example retrieves the contents of the specified trust framework policy on specific output file path.

- `-Id` Parameter specifies ID for a trust framework policy.
- `-OutputFilePath` Parameter specifies the path to the file used for retrieve the contents of trust framework policy.

## Parameters

### -Id

The unique identifier for a trust framework policy.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OutputFilePath

Path to the file used for retrieve the contents of trust framework policy.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[New-EntraBetaTrustFrameworkPolicy](New-EntraBetaTrustFrameworkPolicy.md)

[Set-EntraBetaTrustFrameworkPolicy](Set-EntraBetaTrustFrameworkPolicy.md)

[Remove-EntraBetaTrustFrameworkPolicy](Remove-EntraBetaTrustFrameworkPolicy.md)
