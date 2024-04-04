---
title: Disconnect-Entra.
description: This article provides details on the Disconnect-Entra Command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Disconnect-Entra

## SYNOPSIS
Disconnects the current session from a Microsoft Entra ID tenant.

## SYNTAX

```powershell
Disconnect-Entra
 [-WhatIf] 
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The Disconnect-Entra cmdlet disconnects the current session from a Microsoft Entra ID tenant.

## EXAMPLES

### Example 1: Disconnect your session from a tenant

```powershell
PS C:\> Disconnect-Entra
```

This command disconnects your session from a tenant.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet. Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet isn't run. Shows what would happen if the cmdlet runs.
The cmdlet isn't run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-Entra](Connect-Entra.md)