---
author: msewaweru
description: This article provides details on the Set-EntraBetaTrustFrameworkPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/14/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaTrustFrameworkPolicy
schema: 2.0.0
title: Set-EntraBetaTrustFrameworkPolicy
---

# Set-EntraBetaTrustFrameworkPolicy

## Synopsis

This cmdlet is used to update a trust framework policy (custom policy) in the directory.

## Syntax

### Content (Default)

```powershell
Set-EntraBetaTrustFrameworkPolicy
 [-Id <String>]
 -Content <String>
 [-OutputFilePath <String>]
 [<CommonParameters>]
```

### File

```powershell
Set-EntraBetaTrustFrameworkPolicy
 [-Id <String>]
 -InputFilePath <String>
 [-OutputFilePath <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaTrustFrameworkPolicy` cmdlet is used to update a trust framework policy in the directory.

In delegated scenarios with work or school accounts, the admin must have a supported Microsoft Entra role or a custom role with the required permissions. The `B2C IEF Policy Administrator` is the least privileged role that supports this operation.

## Examples

### Example 1: Updates a trust framework policy from the content specified

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
$params = @{
    Id  = 'B2C_1A_signup_signin'
    Content =  $policyContent
}
Set-EntraBetaTrustFrameworkPolicy @params
```

The example updates a trust framework policy from the content specified.

The contents of updated trust framework policy are displayed on screen.

- `-Id` Parameter specifies ID for a trust framework policy.
- `-Content` Parameter specifies the content of the trust framework policy to be updated.

### Example 2: Updates a trust framework policy from the content specified

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
$params = @{
    Id  = 'B2C_1A_signup_signin'
    Content =  $policyContent
    OutputFilePath = 'C:\UpdatedPolicy.xml'
}
Set-EntraBetaTrustFrameworkPolicy @params
```

The example updates a trust framework policy from the content specified.

The contents of updated trust framework policy are written to file mentioned in output file path.

- `-Id` Parameter specifies ID for a trust framework policy.
- `-Content` Parameter specifies the content of the trust framework policy to be updated.
- `-OutputFilePath` Parameter specifies the path to the file used for updating the contents of trust framework policy.

### Example 3: Updates a trust framework policy from the file mentioned in InputFilePath

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$params = @{
    Id  = 'B2C_1A_signup_signin'
    InputFilePath =  'C:\InputPolicy.xml'
    OutputFilePath = 'C:\UpdatedPolicy.xml'
}
Set-EntraBetaTrustFrameworkPolicy @params
```

The example updates a trust framework policy from the file mentioned in InputFilePath.

The contents of updated trust framework policy are written to file mentioned in output file path.

- `-Id` Parameter specifies ID for a trust framework policy.
- `-InputFilePath` Parameter specifies path to the file used for reading the contents of trust framework policy to be updated.
- `-OutputFilePath` Parameter specifies the path to the file used for updating the contents of trust framework policy.

### Example 4: Updates a trust framework policy from the file mentioned in InputFilePath

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$params = @{
    Id  = 'B2C_1A_signup_signin'
    InputFilePath =  'C:\InputPolicy.xml'
}
Set-EntraBetaTrustFrameworkPolicy @params
```

The example updates a trust framework policy from the file mentioned in InputFilePath.

The contents of updated created trust framework policy are displayed on screen.

- `-Id` Parameter specifies ID for a trust framework policy.
- `-InputFilePath` Parameter specifies path to the file used for reading the contents of trust framework policy to be updated.

## Parameters

### -Content

The content of the trust framework policy to be updated.

```yaml
Type: System.String
Parameter Sets: Content
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id

The unique identifier for a trust framework policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputFilePath

Path to the file used for reading the contents of trust framework policy to be updated.

```yaml
Type: System.String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OutputFilePath

Path to the file used for writing the contents of updated trust framework policy.

```yaml
Type: System.String
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

[Get-EntraBetaTrustFrameworkPolicy](Get-EntraBetaTrustFrameworkPolicy.md)

[New-EntraBetaTrustFrameworkPolicy](New-EntraBetaTrustFrameworkPolicy.md)

[Remove-EntraBetaTrustFrameworkPolicy](Remove-EntraBetaTrustFrameworkPolicy.md)
