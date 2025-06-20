---
author: msewaweru
description: This article provides details on the Get-EntraBetaNamedLocationPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/01/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaNamedLocationPolicy
schema: 2.0.0
title: Get-EntraBetaNamedLocationPolicy
---

# Get-EntraBetaNamedLocationPolicy

## Synopsis

Gets an Microsoft Entra ID named location policy.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaNamedLocationPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaNamedLocationPolicy
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to get the Microsoft Entra ID named location policies.

Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the required permissions. The least privileged roles for this operation are:

- Global Secure Access Administrator (read-only standard properties)  
- Security Reader (read-only standard properties)  
- Security Administrator (read-only standard properties)  
- Global Reader  
- Conditional Access Administrator

## Examples

### Example 1: Retrieves a list of all named location policies in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaNamedLocationPolicy
```

```Output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
dddddddd-3333-4444-5555-eeeeeeeeeeee 31/07/2024 9:53:10   NamedLocation   31/07/2024 9:53:10 
eeeeeeee-4444-5555-6666-ffffffffffff 31/07/2024 4:38:42   NamedLocation1  31/07/2024 4:38:42 
ffffffff-5555-6666-7777-aaaaaaaaaaaa 01/08/2024 4:39:42   NamedLocation2  01/08/2024 4:39:42 
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 01/08/2024 4:57:03   NamedLocation3  01/08/2024 4:57:03 
```

This command retrieves a list of all named location policies in Microsoft Entra ID.

### Example 2: Retrieves a named location policy by Id

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
$policy = Get-EntraBetaNamedLocationPolicy | Where-Object {$_.DisplayName -eq 'Provisioning Workers'}
Get-EntraBetaNamedLocationPolicy -PolicyId $policy.Id
```

```Output
Id                                   CreatedDateTime      DisplayName    ModifiedDateTime
--                                   ---------------      -----------    ----------------
dddddddd-3333-4444-5555-eeeeeeeeeeee 31/07/2024 9:53:10   Provisioning..   31/07/2024 9:53:10
```

This example retrieves a specified named location policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the policy Id of a named location policy.

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

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

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

## Related links

[New-EntraBetaNamedLocationPolicy](New-EntraBetaNamedLocationPolicy.md)

[Set-EntraBetaNamedLocationPolicy](Set-EntraBetaNamedLocationPolicy.md)

[Remove-EntraBetaNamedLocationPolicy](Remove-EntraBetaNamedLocationPolicy.md)
