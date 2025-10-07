---
author: msewaweru
description: This article provides details on the Add-EntraBetaServicePrincipalPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.SignIns
ms.author: eunicewaweru
ms.date: 07/01/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.SignIns/Add-EntraBetaServicePrincipalPolicy
schema: 2.0.0
title: Add-EntraBetaServicePrincipalPolicy
---

# Add-EntraBetaServicePrincipalPolicy

## SYNOPSIS

Adds a servicePrincipal policy.

## SYNTAX

```powershell
Add-EntraBetaServicePrincipalPolicy
 -Id <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaServicePrincipalPolicy` cmdlet adds a service principal policy. Specify the `Id` and `PolicyId` parameter to add a specific servicePrincipal policy.

## EXAMPLES

### Example 1: Add a service principal policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All, Application.ReadWrite.All'
$params = @{
    Id = 'bbbbbbbb-1111-1111-1111-cccccccccccc'
    RefObjectId = 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
}
Add-EntraBetaServicePrincipalPolicy @params
```

This example demonstrates how to add a policy to a service principal in Microsoft Entra ID.

## PARAMETERS

### -RefObjectId

Specifies the object Id of the policy.

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

The ID of the Service Principal for which you need to set the policy

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

[Get-EntraBetaServicePrincipalPolicy](Get-EntraBetaServicePrincipalPolicy.md)

[Remove-EntraBetaServicePrincipalPolicy](Remove-EntraBetaServicePrincipalPolicy.md)
