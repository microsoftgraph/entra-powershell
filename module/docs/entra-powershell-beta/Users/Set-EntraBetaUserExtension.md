---
title: Set-EntraBetaUserExtension
description: This article provides details on the Set-EntraBetaUserExtension command.

ms.topic: reference
ms.date: 03/16/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Users-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaUserExtension

schema: 2.0.0
---

# Set-EntraBetaUserExtension

## Synopsis

Updates a user's extension.

## Syntax

### SetSingle (Default)

```powershell
Set-EntraBetaUserExtension
 -UserId <String>
 -ExtensionName <String>
 -ExtensionValue <String>
 [<CommonParameters>]
```

### SetMultiple

```powershell
Set-EntraBetaUserExtension
 -UserId <String>
 -ExtensionNameValues <System.Collections.Generic.Dictionary`2[System.String,System.String]>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserExtension` cmdlet updates a user's extension in Microsoft Entra ID.

`Update-EntraBetaUserExtension` is an alias for `Set-EntraBetaUserExtension`.

## Examples

### Example 1: Set the value of an extension attribute for a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$extensionName = 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup'
$extensionValue = 'Job Group D'
Set-EntraBetaUserExtension -UserId 'SawyerM@contoso.com' -ExtensionName $extensionName -ExtensionValue $extensionValue
```

This example demonstrates how to update a user's extension attribute for a specified user. Use `(Get-EntraBetaApplicationExtensionProperty -ApplicationId '{ApplicationId}').Name | Select-Object -First 1` to retrieve the extension name.

- `-UserId` parameter specifies the user Id (User Principal Name or UserId).
- `-ExtensionName` parameter specifies the name of an extension.
- `-ExtensionValue` parameter specifies the extension name values.

### Example 2: Update multiple values using ExtensionNameValues parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$userExtensionValues = New-Object 'System.Collections.Generic.Dictionary[String,String]'
$userExtensionValues.Add("extension_d2ba83696c3f45429fbabb363ae391a0_Benefits", "Pension")
$userExtensionValues.Add("extension_d2ba83696c3f45429fbabb363ae391a0_JobGroup", "D")
Set-EntraBetaUserExtension -UserId 'SawyerM@contoso.com' -ExtensionNameValues $userExtensionValues
```

This example demonstrates how to update a user's extension attribute. Use `(Get-EntraBetaApplicationExtensionProperty -ApplicationId '{ApplicationId}').Name | Select-Object -First 1` to retrieve the extension name.

- `-UserId` parameter specifies the user Id (User Principal Name or UserId).
- `-ExtensionNameValues` parameter specifies a dictionary of key-value pairs for the extension name and value pair.

## Parameters

### -UserId

Specifies the unique identifier for the user (User Principal Name or UserId).

```yaml
Type: System.String
Parameter Sets: SetSingle, SetMultiple
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionName

Specifies the name of an extension.

```yaml
Type: System.String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNameValues

Specifies extension name values.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionValue

Specifies an extension value.

```yaml
Type: System.String
Parameter Sets: SetSingle
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

## Notes

`Update-EntraBetaUserExtension` is an alias for `Set-EntraBetaUserExtension`.

## Related Links

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Get-EntraBetaUserExtension](Get-EntraBetaUserExtension.md)

[Remove-EntraBetaUserExtension](Remove-EntraBetaUserExtension.md)
