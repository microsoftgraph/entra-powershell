---
title: Add-EntraBetaApplicationOwner
description: This article provides details on the Add-EntraBetaApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaApplicationOwner

## SYNOPSIS
Adds an owner to an application.

## SYNTAX

```powershell
Add-EntraBetaApplicationOwner 
    -ObjectId <String> 
    -RefObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaApplicationOwner cmdlet adds an owner to a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Add a user as an owner to an application
```powershell
PS C:\> $ApplicationId = (Get-EntraBetaApplication -Top 1).ObjectId
PS C:\> $UserObjectId = (Get-EntraBetaUser -Top 1).ObjectId
PS C:\> Add-EntraBetaApplicationOwner -ObjectId $ApplicationId -RefObjectId $UserObjectId
```

The first command gets an application using [Get-EntraBetaApplication](./Get-EntraBetaApplication.md) cmdlet, and stores 
the ObjectId property value in $ApplicationId variable.  

The second command gets a user using [Get-EntraBetaUser](./Get-EntraBetaUser.md) cmdlet, and stores 
the ObjectId property value in $UserObjectId variable.  

This final command adds an owner in $UserObjectId to an application in $ApplicationId.

This command adds an owner to an application.

## PARAMETERS

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationOwner](Get-EntraBetaApplicationOwner.md)

[Remove-EntraBetaApplicationOwner](Remove-EntraBetaApplicationOwner.md)

