---
title: New-EntraBetaTrustFrameworkPolicy
description: This article provides details on the New-EntraBetaTrustFrameworkPolicy command.


ms.topic: reference
ms.date: 08/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaTrustFrameworkPolicy

schema: 2.0.0
---

# New-EntraBetaTrustFrameworkPolicy

## Synopsis

This cmdlet is used to create a trust framework policy (custom policy) in the directory.

## Syntax

### Content (Default)

```powershell
New-EntraBetaTrustFrameworkPolicy
 -Content <String>
 [-OutputFilePath <String>]
 [<CommonParameters>]
```

### File

```powershell
New-EntraBetaTrustFrameworkPolicy
 -InputFilePath <String>
 [-OutputFilePath <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaTrustFrameworkPolicy` cmdlet is used to create a trust framework policy in the directory.

In delegated scenarios with work or school accounts, the admin must have a supported Microsoft Entra role or a custom role with the required permissions. The `B2C IEF Policy Administrator` is the least privileged role that supports this operation.

## Examples

### Example 1: Creates a trust framework policy from the content specified

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
New-EntraBetaTrustFrameworkPolicy -Content $policyContent
```

The example creates a trust framework policy from the content specified.

The contents of newly created trust framework policy are displayed on screen.

- `-Content` Parameter specifies the content of the trust framework policy to be created.

### Example 2: creates a trust framework policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
$params = @{
    Content =  $policyContent
    OutputFilePath = 'C:\CreatedPolicy.xml'
}
New-EntraBetaTrustFrameworkPolicy @params
```

The example creates a trust framework policy from the content specified.

The contents of newly created trust framework policy are written to file mentioned in output file path.

- `-Content` Parameter specifies the content of the trust framework policy to be created.
- `-OutputFilePath` Parameter specifies the path to the file used for writing the contents of trust framework policy.

### Example 3: Creates a trust framework policy from the file mentioned in InputFilePath

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$params = @{
    InputFilePath = 'C:\InputPolicy.xml'
    OutputFilePath = 'C:\CreatedPolicy.xml'
}
New-EntraBetaTrustFrameworkPolicy @params
```

The example creates a trust framework policy from the file mentioned in InputFilePath.

The contents of newly created trust framework policy are written to file mentioned in output file path.

- `-InputFilePath` Parameter specifies Path to the file used for reading the contents of trust framework policy to be created.
- `-OutputFilePath` Parameter specifies the path to the file used for writing the contents of trust framework policy.

### Example 4: Creates a trust framework policy from the file mentioned in InputFilePath

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
$params = @{
    InputFilePath = 'C:\InputPolicy.xml'
}
New-EntraBetaTrustFrameworkPolicy @params
```

The example creates a trust framework policy from the file mentioned in InputFilePath.

The contents of newly created trust framework policy are displayed on screen.

- `-InputFilePath` Parameter specifies Path to the file used for reading the contents of trust framework policy to be created.

## Parameters

### -Content

The content of the trust framework policy to be created.

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

### -InputFilePath

Path to the file used for reading the contents of trust framework policy to be created.

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

Path to the file used for writing the contents of newly created trust framework policy.

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

[Set-EntraBetaTrustFrameworkPolicy](Set-EntraBetaTrustFrameworkPolicy.md)

[Remove-EntraBetaTrustFrameworkPolicy](Remove-EntraBetaTrustFrameworkPolicy.md)
