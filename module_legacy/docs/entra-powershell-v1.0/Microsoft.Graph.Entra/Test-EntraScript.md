---
title: Test-EntraScript
description: This article provides details on the Test-EntraScript command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Test-EntraScript
schema: 2.0.0
---

# Test-EntraScript

## Synopsis

Checks if the provided script uses Azure AD commands compatible with the Microsoft Entra PowerShell module.

## Syntax

```powershell
Test-EntraScript
 -Path <String[]>
 [-Content <String>]
 [-Quiet]
 [<CommonParameters>]
```

## Description

Checks if the provided script uses Azure AD commands compatible with the Microsoft Entra PowerShell module.

## Examples

### Example 1

```powershell
Test-EntraScript -Path .\usercreation.ps1 -Quiet
```

Returns whether the script `usercreation.ps1` could run under Microsoft.Graph.Entra.

### Example 2

```powershell
Get-ChildItem -Path \\contoso.com\it\code -Recurse -Filter *.ps1 | Test-EntraScript
```

Returns a list of all scripts that wouldn't run under the Microsoft.Graph.Entra module, listing each issue with line and code.

## Parameters

### -Path

Path to one or more script files to scan.
Or name of the content, when also specifying -Content

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: FullName, Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Content

Code content to scan.
Used when scanning code that has no file representation (for example,
straight from a repository).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Quiet

Only return $true or $ false, based on whether the script could run under Microsoft.Graph.Entra ($true) or not ($ false)

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
