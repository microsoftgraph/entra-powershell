---
title: Get-EntraBetaApplicationPolicy
description: This article provides details on the Get-EntraBetaApplicationPolicy command.


ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationPolicy

schema: 2.0.0
---

# Get-EntraBetaApplicationPolicy

## Synopsis

Gets an application policy.

## Syntax

```powershell
Get-EntraBetaApplicationPolicy
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationPolicy` cmdlet gets a Microsoft Entra ID application policy.

## Examples

### Example 1: Get an application policy

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Get-EntraBetaApplicationPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Definition                                                                                       DeletedDateTime Description DisplayName Id
----------                                                                                       --------------- ----------- ----------- --
{{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                             NewUpdated  aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command gets the specified application policy.

- `-Id` Parameter Specifies the ID of the application for which you need to retrieve the policy.

## Parameters

### -Id

The ID of the application for which you need to retrieve the policy.

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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaApplicationPolicy](Add-EntraBetaApplicationPolicy.md)

[Remove-EntraBetaApplicationPolicy](Remove-EntraBetaApplicationPolicy.md)
