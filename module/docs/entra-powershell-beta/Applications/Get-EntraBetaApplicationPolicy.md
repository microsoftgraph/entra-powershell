---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationPolicy command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/05/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationPolicy
schema: 2.0.0
title: Get-EntraBetaApplicationPolicy
---

# Get-EntraBetaApplicationPolicy

## SYNOPSIS

Gets an application policy.

## SYNTAX

```powershell
Get-EntraBetaApplicationPolicy
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationPolicy` cmdlet gets a Microsoft Entra ID application policy.

## EXAMPLES

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

## PARAMETERS

### -Id

The ID of the application for which you need to retrieve the policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, ApplicationId

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

[Add-EntraBetaApplicationPolicy](Add-EntraBetaApplicationPolicy.md)

[Remove-EntraBetaApplicationPolicy](Remove-EntraBetaApplicationPolicy.md)
