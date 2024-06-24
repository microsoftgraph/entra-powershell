---
title: Get-EntraBetaMSGroupLifecyclePolicy.
description: This article provides details on the Get-EntraBetaMSGroupLifecyclePolicy command.

ms.service: entra
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

# Get-EntraBetaMSGroupLifecyclePolicy

## SYNOPSIS
Retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraBetaMSGroupLifecyclePolicy 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaMSGroupLifecyclePolicy 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-EntraBetaMSGroupLifecyclePolicy` command retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID. Specify the `-Id` parameter to get the group lifecycle policy.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## EXAMPLES

### Example 1: Retrieve all groupLifecyclePolicies
```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaMSGroupLifecyclePolicy
```
```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
c9a455d8-982e-4c06-86d8-8dab15f03295 example@contoso.un          99                  Selected
```

This example demonstrates how to retrieve the properties and relationships of all groupLifecyclePolicies in Microsoft Entra ID.
This command retrieves the group expiration settings configured for the tenant.

### Example 2: Retrieve properties of an groupLifecyclePolicy

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaMSGroupLifecyclePolicy -Id '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 admingroup@contoso.com      200                 All
```

This command is used to retrieve a specific Microsoft Group Lifecycle Policy. The Id parameter specifies the ID of the Lifecycle Policy to be retrieved.

## PARAMETERS

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

## INPUTS

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Set-EntraBetaMSGroupLifecyclePolicy](Set-EntraBetaMSGroupLifecyclePolicy.md)

[New-EntraBetaMSGroupLifecyclePolicy](New-EntraBetaMSGroupLifecyclePolicy.md)

[Remove-EntraBetaMSGroupLifecyclePolicy](Remove-EntraBetaMSGroupLifecyclePolicy.md)
