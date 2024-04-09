---
title: Set-EntraBetaApplicationProxyConnectorGroup.
description: This article provides details on the Set-EntraBetaApplicationProxyConnectorGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 04/02/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS
The Set-EntraBetaApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## SYNTAX

```powershell
Set-EntraBetaApplicationProxyConnectorGroup 
 -Id <String> 
 -Name <Name> 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraBetaApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## EXAMPLES

### Example 1: Rename a Connector Group to "Offsite Application Servers"
```powershell
PS C:\> Set-EntraBetaApplicationProxyConnectorGroup -Id d533d7b1-fd92-49e8-a200-3e7dcf7c2ab5 -Name "Offsite Application Servers"
```
This command Rename a Connector Group to "Offsite Application Servers"

## PARAMETERS

### -Id
The unique identifier of the Connector group that should be renamed.
You can find the ID using the Get-EntraBetaApplicationProxyConnectorGroup command.

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

### -Name
The new name for the Connector group.

```yaml
Type: Name
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

## OUTPUTS

## NOTES

## RELATED LINKS