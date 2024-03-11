---
title: Remove-EntraBetaApplicationPolicy.
description: This article provides details on the Remove-EntraBetaApplicationPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
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
The **Remove-EntraBetaApplicationPolicy** cmdlet removes an application policy from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application policy
```powershell
PS C:\>Remove-AzureADApplicationPolicy -Id e3108c4d-86ff-4ceb-9429-24e85b4b8cea -PolicyId 3789ac74-16df-4c22-8ffe-6fc1cb30a399
```

This command removes the specified application policy.

## PARAMETERS

### -PolicyId
Specifies the ID of the policy.

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

### -Id
Specifies the ID of an application in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaApplicationPolicy](Add-EntraBetaApplicationPolicy.md)

[Get-EntraBetaApplicationPolicy](Get-EntraBetaApplicationPolicy.md)

