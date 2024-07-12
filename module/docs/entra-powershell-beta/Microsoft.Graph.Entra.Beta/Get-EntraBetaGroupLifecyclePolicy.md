---
title: Get-EntraBetaGroupLifecyclePolicy.
description: This article provides details on the Get-EntraBetaGroupLifecyclePolicy command.


ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupLifecyclePolicy

## Synopsis

Retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaGroupLifecyclePolicy 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaGroupLifecyclePolicy 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaGroupLifecyclePolicy` command retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID. Specify the `-Id` parameter to get the group lifecycle policy.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## Examples

### Example 1: Retrieve all groupLifecyclePolicies

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaGroupLifecyclePolicy
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
eeeeeeee-4444-5555-6666-ffffffffffff example@contoso.un          99                  Selected
```

This example demonstrates how to retrieve the properties and relationships of all groupLifecyclePolicies in Microsoft Entra ID.

### Example 2: Retrieve properties of an groupLifecyclePolicy

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaGroupLifecyclePolicy -Id 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa admingroup@contoso.com      200                 All
```

This command is used to retrieve a specific Microsoft Group Lifecycle Policy. The Id parameter specifies the ID of the Lifecycle Policy to be retrieved.

## Parameters

### -ID

Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

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

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related Links

[Set-EntraBetaGroupLifecyclePolicy](Set-EntraBetaGroupLifecyclePolicy.md)

[New-EntraBetaGroupLifecyclePolicy](New-EntraBetaGroupLifecyclePolicy.md)

[Remove-EntraBetaGroupLifecyclePolicy](Remove-EntraBetaGroupLifecyclePolicy.md)
