---
title: Get-EntraNamedLocationPolicy
description: This article provides details on the Get-EntraNamedLocationPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraNamedLocationPolicy

## Synopsis

Gets a Microsoft Entra ID named location policy.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraNamedLocationPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraNamedLocationPolicy
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to get the Microsoft Entra ID named location policies.
Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

## Examples

### Example 1: Retrieves a list of all named location policies in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraNamedLocationPolicy
```

```output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
dddddddd-3333-4444-5555-eeeeeeeeeeee 3/1/2024 9:53:10 AM  NamedLocation  3/1/2024 9:53:10 AM
eeeeeeee-4444-5555-6666-ffffffffffff 3/4/2024 4:38:42 AM  NamedLocation  3/4/2024 4:38:42 AM
ffffffff-5555-6666-7777-aaaaaaaaaaaa 3/4/2024 4:39:42 AM  NamedLocation  3/4/2024 4:39:42 AM
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 3/4/2024 4:57:03 AM  NamedLocation  3/4/2024 4:57:03 AM
```

This command retrieves a list of all named location policies in Microsoft Entra ID.

### Example 2: Retrieves a named location policy in Microsoft Entra ID with given Id

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraNamedLocationPolicy -PolicyId 'dddddddd-3333-4444-5555-eeeeeeeeeeee'
```

```output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
dddddddd-3333-4444-5555-eeeeeeeeeeee 3/1/2024 9:53:10 AM  NamedLocation  3/1/2024 9:53:10 AM
```

This command retrieves a named location policy specified by the `-PolicyID` in Microsoft Entra ID.

## Parameters

### -PolicyId

Specifies the ID of a named location policy in Microsoft Entra ID.

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

### -Property

Specifies properties to be returned

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

## Outputs

## Notes

## Related Links

[New-EntraNamedLocationPolicy](New-EntraNamedLocationPolicy.md)

[Set-EntraNamedLocationPolicy](Set-EntraNamedLocationPolicy.md)

[Remove-EntraNamedLocationPolicy](Remove-EntraNamedLocationPolicy.md)

