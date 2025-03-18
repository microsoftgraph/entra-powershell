---
title: Set-EntraUserExtension
description: This article provides details on the Set-EntraUserExtension command.

ms.topic: reference
ms.date: 03/16/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserExtension

schema: 2.0.0
---

# Set-EntraUserExtension

## Synopsis

Sets a user extension.

## Syntax

### SetSingle (Default)

```powershell
Set-EntraUserExtension
 -UserId <String>
 -ExtensionName <String>
 -ExtensionValue <String>
 [<CommonParameters>]
```

### SetMultiple

```powershell
Set-EntraUserExtension
 -UserId <String>
 -ExtensionNameValues <System.Collections.Generic.Dictionary`2[System.String,System.String]>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserExtension` cmdlet updates a user extension in Microsoft Entra ID.

`Update-EntraUserExtension` is an alias for `Set-EntraUserExtension`.

## Examples

### Example 1: Set the value of an extension attribute for a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$extensionName = 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup'
$extensionValue = 'Job Group D'
Set-EntraUserExtension -UserId 'SawyerM@contoso.com' -ExtensionName $extensionName -ExtensionValue $extensionValue
```

This example shows how to update the value of the extension attribute for a specified user.

- `-UserId` parameter specifies the user Id.
- `-ExtensionName` parameter specifies the name of an extension.
- `-ExtensionValue` parameter specifies the extension name values.

You can use the snippet next section to retrieve the extension name:

```PowerShell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$extensionName = (Get-EntraApplicationExtensionProperty -ApplicationId $application.Id).Name | Select-Object -First 1
```

### Example 2: Update multiple values using ExtensionNameValues parameter

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$userExtensionValues = New-Object 'System.Collections.Generic.Dictionary[String,String]'
$userExtensionValues.Add("extension_d2ba83696c3f45429fbabb363ae391a0_Benefits", "Pension")
$userExtensionValues.Add("extension_d2ba83696c3f45429fbabb363ae391a0_JobGroup", "D")
Set-EntraUserExtension -UserId 'SawyerM@contoso.com' -ExtensionNameValues $userExtensionValues
```

This example shows how to update the value of the extension attribute for a specified user.

- `-UserId` parameter specifies the user Id.
- `-ExtensionNameValues` parameter specifies a dictionary of key-value pairs for the extension name and value pair.

You can use the snippet in the next section to retrieve the extension name:

```PowerShell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$extensionName = (Get-EntraApplicationExtensionProperty -ApplicationId $application.Id).Name | Select-Object -First 1
```

## Parameters

### -UserId

Specifies the ID of the user.

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

`Update-EntraUserExtension` is an alias for `Set-EntraUserExtension`.

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)
