---
title: Add-EntraBetaAdministrativeUnitMember.
description: This article provides details on the Add-EntraBetaAdministrativeUnitMember command.

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

# Add-EntraBetaAdministrativeUnitMember

## SYNOPSIS
Adds an administrative unit member.

## SYNTAX

```
Add-EntraBetaAdministrativeUnitMember 
 -RefObjectId <String> 
 -ObjectId <String>
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaAdministrativeUnitMember cmdlet adds an Active Directory administrative unit member.

## EXAMPLES

### Example 1: Add an member to AdministrativeUnit
```powershell
PS C:\> Add-EntraBetaAdministrativeUnitMember -ObjectId 0e3840ee-40b6-4b72-827b-c06e1f59d2be -RefObjectId 412be9d1-1460-4061-8eed-cca203fcb215
```

This command adds an existing user to Administrative Unit.

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
Specifies the ID of an Active Directory administrative unit.

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
Specifies the unique ID of the specific Microsoft Entra ID object that will be assigned as owner/manager/member.

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

[Get-EntraBetaAdministrativeUnitMember]()

[Remove-EntraBetaAdministrativeUnitMember]()

