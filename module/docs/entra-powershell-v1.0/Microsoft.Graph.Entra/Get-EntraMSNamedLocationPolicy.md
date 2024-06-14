---
title: Get-EntraMSNamedLocationPolicy
description: This article provides details on the Get-EntraMSNamedLocationPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSNamedLocationPolicy

## SYNOPSIS

Gets a Microsoft Entra ID named location policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraMSNamedLocationPolicy 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSNamedLocationPolicy 
 -PolicyId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet allows an admin to get the Microsoft Entra ID named location policies.
Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

## EXAMPLES

### Example 1: Retrieves a list of all named location policies in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraMSNamedLocationPolicy
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
Get-EntraMSNamedLocationPolicy -PolicyId 'dddddddd-3333-4444-5555-eeeeeeeeeeee'
```

```output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
dddddddd-3333-4444-5555-eeeeeeeeeeee 3/1/2024 9:53:10 AM  NamedLocation  3/1/2024 9:53:10 AM
```

This command retrieves a named location policy specified by the `-PolicyID` in Microsoft Entra ID.

## PARAMETERS

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraMSNamedLocationPolicy](New-EntraMSNamedLocationPolicy.md)

[Set-EntraMSNamedLocationPolicy](Set-EntraMSNamedLocationPolicy.md)

[Remove-EntraMSNamedLocationPolicy](Remove-EntraMSNamedLocationPolicy.md)

