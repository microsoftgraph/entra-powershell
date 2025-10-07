---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationPolicy command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/05/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Remove-EntraBetaApplicationPolicy
schema: 2.0.0
title: Remove-EntraBetaApplicationPolicy
---

# Remove-EntraBetaApplicationPolicy

## SYNOPSIS

Removes an application policy.

## SYNTAX

```powershell
Remove-EntraBetaApplicationPolicy
 -Id <String>
 -PolicyId <String>
[<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplicationPolicy` cmdlet removes an application policy from Microsoft Entra ID. Specify `Id`and `PolicyId` parameters to remove an specific application policy.

## EXAMPLES

### Example 1: Remove an application policy

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    PolicyId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Remove-EntraBetaApplicationPolicy @params
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaApplicationPolicy](Add-EntraBetaApplicationPolicy.md)

[Get-EntraBetaApplicationPolicy](Get-EntraBetaApplicationPolicy.md)
