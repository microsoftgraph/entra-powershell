---
title: Get-EntraMSGroupLifecyclePolicy.
description: This article provides details on the Get-EntraMSGroupLifecyclePolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSGroupLifecyclePolicy

## SYNOPSIS
Retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## SYNTAX

### GetQuery (Default)
```
Get-EntraMSGroupLifecyclePolicy 
 [<CommonParameters>]
```

### GetById
```
Get-EntraMSGroupLifecyclePolicy 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSGroupLifecyclePolicy command retrieves the properties and relationships of a groupLifecyclePolicies object in Microsoft Entra ID.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## EXAMPLES

### Example 1: Retrieve all groupLifecyclePolicies
```powershell
PS C:\> Get-EntraMSGroupLifecyclePolicy
```
```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
098e32e0-06e0-4ca2-b398-f521b6a7ddef admingroup@contoso.com      200                 All

```

This example demonstrates how to retrieve the properties and relationships of all groupLifecyclePolicies in Microsoft Entra ID.    
This command retrieves the group expiration settings configured for the tenant.

### Example 2: Retrieve properties of an groupLifecyclePolicy 
```powershell
PS C:\> Get-EntraMSGroupLifecyclePolicy -Id "098e32e0-06e0-4ca2-b398-f521b6a7ddef"
```
```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
098e32e0-06e0-4ca2-b398-f521b6a7ddef admingroup@contoso.com      200                 All
```

This example demonstrates how to retrieve the properties and relationships of a specified groupLifecyclePolicy in Microsoft Entra ID.

## PARAMETERS

### -Id
Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

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

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
