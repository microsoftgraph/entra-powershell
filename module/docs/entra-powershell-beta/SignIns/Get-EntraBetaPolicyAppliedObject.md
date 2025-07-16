---
author: msewaweru
description: This article provides details on the Get-EntraBetaPolicyAppliedObject command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/13/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaPolicyAppliedObject
schema: 2.0.0
title: Get-EntraBetaPolicyAppliedObject
---

# Get-EntraBetaPolicyAppliedObject

## SYNOPSIS

Gets a policy-applied object from Microsoft Entra ID.

## SYNTAX

```powershell
Get-EntraBetaPolicyAppliedObject
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaPolicyAppliedObject` cmdlet gets a policy-applied object from Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve a policy-applied object

```powershell
Connect-Entra -Scopes 'Application.Read.All', 'Policy.ReadWrite.ApplicationConfiguration'
Get-EntraBetaPolicyAppliedObject -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-1111-1111-1111-000000000000
bbbbcccc-1111-dddd-2222-eeee3333ffff
```

This command retrieves policy-applied object from Microsoft Entra ID.

- `-Id` Parameter specifies ID of the policy for which you want to find the objects.

## PARAMETERS

### -Id

The ID of the policy for which you want to find the objects.

```yaml
Type: System.String
Parameter Sets: (All)
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
