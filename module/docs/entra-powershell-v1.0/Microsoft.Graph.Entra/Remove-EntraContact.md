---
title: Remove-EntraContact
description: This article provides details on the Remove-EntraContact command.

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

# Remove-EntraContact

## SYNOPSIS
Removes a contact.

## SYNTAX

```powershell
Remove-EntraContact 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraContact removes a contact from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a contact
```powershell
PS C:\> $Contact = Get-EntraContact -Top 1
PS C:\> Remove-EntraContact -ObjectId $Contact.ObjectId
```

The first command gets a contact by using the [Get-EntraContact](./Get-EntraContact.md) cmdlet, and then stores it in the $Contact variable.

The second command removes the contact in $Contact.

## PARAMETERS

### -ObjectId
Specifies the object ID of a contact in Microsoft Entra ID.

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

[Get-EntraContact](Get-EntraContact.md)

