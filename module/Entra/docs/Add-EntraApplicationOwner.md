---
title: Add-EntraApplicationOwner
description: This article provides details on the Add-EntraApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraApplicationOwner

## SYNOPSIS
Adds an owner to an application.

## SYNTAX

```powershell
Add-EntraApplicationOwner 
    -ObjectId <String> 
    -RefObjectId <String> 
    [-InformationAction <ActionPreference>] 
    [-InformationVariable <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraApplicationOwner cmdlet adds an owner to a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Add a user as an owner to an application
```powershell
PS C:\> $ApplicationId = (Get-EntraApplication -Top 1).ObjectId
PS C:\> $UserObjectId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Add-EntraApplicationOwner -ObjectId $ApplicationId -RefObjectId $UserObjectId
```

This command adds an owner to an application.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are: * Continue

* Ignore
* Inquire
* SilentlyContinue
* Stop
* Suspend

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
Specifies a variable in which to store an information event message.

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

### -RefObjectId
Specifies the ID of the Active Directory object to assign as owner/manager/member.

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

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)

