---
title: Get-EntraMSLifecyclePolicyGroup.
description: This article provides details on the Get-EntraMSLifecyclePolicyGroup command.

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

# Get-EntraMSLifecyclePolicyGroup

## SYNOPSIS

Retrieves the lifecycle policy object to which a group belongs.

## SYNTAX

```powershell
Get-EntraMSLifecyclePolicyGroup 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraMSLifecyclePolicyGroup retrieves the lifecycle policy object to which a group belongs.

## EXAMPLES

### Example 1: Retrieve lifecycle policy object

```powershell
PS C:\>Connect-Entra -Scopes 'Directory.Read.All'
PS C:\>Get-EntraMSLifecyclePolicyGroup -Id '056b2531-005e-4f3e-be78-01a71ea30a04'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
098e32e0-06e0-4ca2-b398-f521b6a7ddef admingroup@contoso.com      200                 All
```

This example demonstrates how to retrieve lifecycle policy object by Id in Microsoft Entra ID.  
This command retrieves the lifecycle policy object to which a group belongs.

This command is used to retrieve the groups associated with a specific Microsoft Lifecycle Policy. The -Id parameter specifies the ID of the Lifecycle Policy whose associated groups should be retrieved.

## PARAMETERS

### -Id

Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
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

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
