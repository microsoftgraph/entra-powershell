---
author: msewaweru
description: This article provides details on the Get-EntraGroupLifecyclePolicy command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Groups
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Groups/Get-EntraGroupLifecyclePolicy
schema: 2.0.0
title: Get-EntraGroupLifecyclePolicy
---

# Get-EntraGroupLifecyclePolicy

## SYNOPSIS

Retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraGroupLifecyclePolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraGroupLifecyclePolicy
 -GroupLifecyclePolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraGroupLifecyclePolicy` command retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID. Specify the `-GroupLifecyclePolicyId` parameter to get the group lifecycle policy.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## EXAMPLES

### Example 1: Retrieve all groupLifecyclePolicies

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraGroupLifecyclePolicy
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
eeeeeeee-4444-5555-6666-ffffffffffff example@contoso.com                     200                 Selected
```

This example demonstrates how to retrieve the properties and relationships of all groupLifecyclePolicies in Microsoft Entra ID.

### Example 2: Retrieve properties of an groupLifecyclePolicy

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$policy = Get-EntraGroupLifecyclePolicy | Where-Object {$_.AlternateNotificationEmails -eq 'example@contoso.com'}
Get-EntraGroupLifecyclePolicy -GroupLifecyclePolicyId $policy.Id
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa example@contoso.com                     200                 Selected
```

This command is used to retrieve a specific Microsoft Group Lifecycle Policy.

- `-GroupLifecyclePolicyId` parameter specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

## PARAMETERS

### -GroupLifecyclePolicyId

Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
