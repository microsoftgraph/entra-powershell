---
title: Get-EntraMSNamedLocationPolicy
description: This article provides details on the Get-EntraMSNamedLocationPolicy command.

ms.service: active-directory
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
This cmdlet allows an admin to get the Microsoft Entra ID named location policy.
Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

## EXAMPLES

### Example 1: Retrieves a list of all named location policies in Microsoft Entra ID.
```powershell
PS C:\> Get-EntraMSNamedLocationPolicy
```

```output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
16f927bc-5514-488e-bb2c-dbd014b774a2 3/1/2024 9:53:10 AM  NamedLocation  3/1/2024 9:53:10 AM
0234e763-751b-4950-9d0f-d096e94e42e1 3/4/2024 4:38:42 AM  NamedLocation  3/4/2024 4:38:42 AM
1cde1377-c070-4a10-ae12-eb958f315832 3/4/2024 4:39:42 AM  NamedLocation  3/4/2024 4:39:42 AM
0ef0c81b-4bd4-4e73-9344-51e7699a06ff 3/4/2024 4:57:03 AM  NamedLocation  3/4/2024 4:57:03 AM
```

This command retrieves a list of all named location policies in Microsoft Entra ID.

### Example 2: Retrieves a named location policy in Microsoft Entra ID with given Id.
```powershell
PS C:\> Get-EntraMSNamedLocationPolicy -PolicyId 1b7f0916-7677-40d8-97a1-d606f4ed8fcf
```

```output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
1b7f0916-7677-40d8-97a1-d606f4ed8fcf 3/1/2024 9:53:10 AM  NamedLocation  3/1/2024 9:53:10 AM
```

This command retrieves a named location policy in Microsoft Entra ID.

## PARAMETERS

### -PolicyId
Specifies the ID of a named location policy in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
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

[New-EntraMSNamedLocationPolicy](New-EntraMSNamedLocationPolicy.md)

[Set-EntraMSNamedLocationPolicy](Set-EntraMSNamedLocationPolicy.md)

[Remove-EntraMSNamedLocationPolicy](Remove-EntraMSNamedLocationPolicy.md)

