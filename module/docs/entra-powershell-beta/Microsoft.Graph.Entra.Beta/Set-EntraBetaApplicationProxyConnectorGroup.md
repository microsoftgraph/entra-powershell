---
Title: Set-EntraBetaApplicationProxyConnectorGroup.
Description: This article provides details on the Set-EntraBetaApplicationProxyConnectorGroup command.

Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Set-EntraBetaApplicationProxyConnectorGroup

## Synopsis
The Set-EntraBetaApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## Syntax

```powershell
Set-EntraBetaApplicationProxyConnectorGroup 
 -Id <String> 
 -Name <Name> 
 [<CommonParameters>]
```

## Description
The Set-EntraBetaApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## Examples

### Example 1: Rename a Connector Group to "Offsite Application Servers"
```powershell
PS C:\> Set-EntraBetaApplicationProxyConnectorGroup -Id d533d7b1-fd92-49e8-a200-3e7dcf7c2ab5 -Name "Offsite Application Servers"
```
This command Rename a Connector Group to "Offsite Application Servers"

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links
