---
title: Remove-EntraApplicationPolicy.
description: This article provides details on the Remove-EntraApplicationPolicy command.
ms.service: active-directory
ms.topic: reference
ms.date: 06/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationPolicy

## SYNOPSIS

Removes an application policy.

## SYNTAX

```powershell
Remove-EntraApplicationPolicy 
 -Id <String> 
 -PolicyId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraApplicationPolicy` cmdlet removes an application policy from Microsoft Entra ID. Specify the `Id` and `PolicyId` parameter to remove an application policy.

## EXAMPLES

### Example 1: Remove an application policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All,Application.ReadWrite.OwnedBy, Policy.Read.All, Application.ReadWrite.All, Policy.ReadWrite.ApplicationConfiguration, Application.ReadWrite.OwnedBy, Policy.ReadWrite.ApplicationConfiguration, Application.ReadWrite.All'
Remove-EntraApplicationPolicy -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PolicyId '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5'
```

This command removes the specified application policy.

## PARAMETERS

### -PolicyId

Specifies the ID of the policy.

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

### -Id

Specifies the ID of Policy.

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

[Add-EntraApplicationPolicy](Add-EntraApplicationPolicy.md)

[Get-EntraADApplicationPolicy](Get-EntraADApplicationPolicy.md)
