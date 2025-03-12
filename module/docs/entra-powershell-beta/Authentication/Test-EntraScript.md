---
title: Test-EntraScript
description: This article provides details on the Test-EntraScript command.

ms.topic: reference
ms.date: 02/05/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Authentication-Help.xml
Module Name: Microsoft.Entra.Beta
online version: <https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Authentication/Test-EntraScript>

schema: 2.0.0
---

# Test-EntraScript

## Synopsis

Checks whether the provided script is using AzureAD commands that are not supported by Microsoft.Entra.Beta.

## Syntax

### TestQuery (Default)

```powershell
Test-EntraScript
 [-Path <String>]
 [-Content <String>]
 [-Quiet <Switch>]
 [<CommonParameters>]
```

## Description

`Test-EntraScript` checks whether the provided script is using AzureAD commands that are not supported by Microsoft.Entra.Beta.Beta. This cmdlet can scan scripts from a file or from code content directly. It helps identify potential issues with using the Microsoft.Entra.Beta module instead of the AzureAD module.

## Examples

### Example 1: Check if a script could run under Microsoft.Entra.Beta with quiet output

```powershell
PS C:\> Test-EntraScript -Path .\usercreation.ps1 -Quiet
```

```Output
$true
```

This example returns whether the script `usercreation.ps1` could run under the Microsoft.Entra.Beta module (`$true`) or not (`$false`).

### Example 2: Check all scripts in a directory for compatibility with Microsoft.Entra

```powershell
PS C:\> Get-ChildItem -Path \\contoso.com\it\code -Recurse -Filter *.ps1 | Test-EntraScript
```

```Output
Test-EntraScript : The script 'usercreation.ps1' contains the following issues:
Line 23: Using the AzureAD cmdlet 'Get-AzureADUser'.
Line 42: Using the AzureAD cmdlet 'Set-AzureADUser'.
```

This example returns a list of all scripts that would not run under the Microsoft.Entra.Beta module, listing each issue with the line number and corresponding code.

## Parameters

### -Path

Specifies the path to the script file(s) to scan. This is used when you are scanning one or more script files directly.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Content

Specifies the code content to scan. Use this parameter when scanning code that has no file representation, such as code directly from a repository.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Quiet

When specified, only returns `$true` or `$false`, indicating whether the script could run under Microsoft.Entra.Beta (`$true`) or not (`$false`).

```yaml
Type: System.SwitchParameter
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

This cmdlet does not accept any specific input types other than the parameters listed.

## Outputs

This cmdlet returns:

- A boolean value (`$true` or `$false`) if the `-Quiet` parameter is used.
- A list of issues, including line numbers and code, if the script is incompatible with Microsoft.Entra.Beta.

## Notes

- The cmdlet checks for the usage of AzureAD-specific cmdlets and other compatibility issues.
- It is useful for ensuring that scripts designed for AzureAD will run under the Microsoft.Entra.Beta module.

## Related Links

- [Microsoft.Entra PowerShell Module](https://learn.microsoft.com/powershell/module/microsoft.entra.beta/)
