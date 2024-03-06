---
title: Add-EntraServicePrincipalOwner
description: This article provides details on the Add-EntraServicePrincipalOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraServicePrincipalOwner

## SYNOPSIS
Adds an owner to a service principal.

## SYNTAX

```
Add-EntraServicePrincipalOwner 
-ObjectId <String> 
-RefObjectId <String> 
[-InformationAction <ActionPreference>]
[-InformationVariable <String>] 
[<CommonParameters>]
```

## DESCRIPTION
The Add-EntraServicePrincipalOwner cmdlet adds an owner to a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Add a user as an owner to a service principal
```
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> $OwnerId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Add-EntraServicePrincipalOwner -ObjectId $ServicePrincipalId -RefObjectId -$OwnerId
```

The first command gets the object ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md)cmdlet, and then stores it in the $ServicePrincipalId variable.

The second command gets the object ID a user by using the Get-EntraUser (./Get-EntraUser.md)cmdlet, and then stores it in the $OwnerId variable.

The final command adds the user specified by $OwnerId an owner to a service principal specified by $ServicePrincipalId.

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
Specifies the ID of a service principal in Microsoft Entra ID.

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
Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

[Get-EntraServicePrincipal]()

[Get-EntraServicePrincipalOwner]()

[Remove-EntraServicePrincipalOwner]()

