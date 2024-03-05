---
title: Get-EntraApplicationExtensionProperty.
description: This article provides details on the Get-EntraApplicationExtensionProperty command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationExtensionProperty

## SYNOPSIS
Gets application extension properties.

## SYNTAX

```
Get-EntraApplicationExtensionProperty 
 -ObjectId <String> 
 [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplicationExtensionProperty cmdlet gets application extension properties in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get extension properties
```
PS C:\>Get-EntraApplicationExtensionProperty -ObjectID 010cc9b5-fce9-485e-9566-c68debafac5f

DeletedDateTime Id                                   AppDisplayName DataType IsSyncedFromOnPremises Name                                                     TargetObjects
--------------- --                                   -------------- -------- ---------------------- ----                                                     -------------
                aae84ce7-62fb-4d16-87e8-af4e2e865096                String   False                  extension_5f783237345745d893e7a0edb1cfbfd1_NewAttribute3 {}
                99429b1a-602c-4a78-b797-f63850ba1af7                String   False                  extension_5f783237345745d893e7a0edb1cfbfd1_NewAttribute1 {}
                f2bfdbb9-e5d3-4ff9-8fb1-4e5d36726875                String   False                  extension_5f783237345745d893e7a0edb1cfbfd1_NewAttribute  {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

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

### -ObjectId
Specifies the unique ID of an application in Microsoft Entra ID.

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

[New-EntraApplicationExtensionProperty]()

[Remove-EntraApplicationExtensionProperty]()

