---
title: Remove-EntraBetaPolicy.
description: This article provides details on the Remove-EntraBetaPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaPolicy

## SYNOPSIS
Removes a policy.

## SYNTAX

```
Remove-EntraBetaPolicy
 -Id <String> 
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaPolicy cmdlet removes a policy from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a policy
```
PS C:\>Remove-EntraBetaPolicy -Id da0bce5a-d2d2-4d68-9816-967d05f93eb2
```

This command removes the specified policy.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id of the policy you want to remove

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

[Get-EntraBetaPolicy]()

[New-EntraBetaPolicy]()

[Set-EntraBetaPolicy]()

