---
title: Remove-EntraApplicationPasswordCredential.
description: This article provides details on the Remove-EntraApplicationPasswordCredential command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationPasswordCredential

## SYNOPSIS
Removes a password credential from an application.

## SYNTAX

```
Remove-EntraApplicationPasswordCredential 
-ObjectId <String> -KeyId <String>
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraApplicationPasswordCredential cmdlet removes a password credential from an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application password credential
```
PS C:\> $AppID = (Get-EntraApplication -Top 1).objectId
PS C:\> $KeyIDs = Get-EntraApplicationPasswordCredential -ObjectId $AppId
PS C:\> Remove-EntraApplicationPasswordCredential -ObjectId $AppId -KeyId $KeyIds[0].KeyId
```

The first command gets the ID of an application by using the Get-EntraApplication (./Get-EntraApplication.md) cmdlet, and then stores it in the $AppID variable.

The second command gets the password credential for the application identified by $AppID by using the Get-EntraApplicationPasswordCredential (./ Get-EntraApplicationPasswordCredential.md) cmdlet. 
The command stores it in the $KeyId variable.

The final command removes the application password credential for the application identified by $AppID.

## PARAMETERS

### -KeyId
@{Text=}

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

### -ObjectId
Specifies the ID of the application in Microsoft Entra ID.

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

[Get-EntraApplication](Get-EntraApplication.md)

[Get-EntraApplicationPasswordCredential](Get-EntraApplicationPasswordCredential.md)

[Remove-EntraApplicationPasswordCredential](Remove-EntraApplicationPasswordCredential.md)

