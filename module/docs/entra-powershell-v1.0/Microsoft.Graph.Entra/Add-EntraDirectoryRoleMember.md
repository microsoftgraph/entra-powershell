---
title: Add-EntraDirectoryRoleMember
description: This article provides details on the Add-EntraDirectoryRoleMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraDirectoryRoleMember

## SYNOPSIS
Adds a member to a directory role.

## SYNTAX

```powershell
Add-EntraDirectoryRoleMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The **Add-EntraDirectoryRoleMember** cmdlet adds a member to a Microsoft Entra ID role.

## EXAMPLES

### Example 1: Add a member to a Microsoft Entra ID role
```powershell
PS C:\>Add-EntraDirectoryRoleMember -ObjectId 019ea7a2-1613-47c9-81cb-20ba35b1ae48 -RefObjectId c13dd34a-492b-4561-b171-40fcce2916c5
```

This command adds a member to a Microsoft Entra ID role.

## PARAMETERS

### -ObjectId
Specifies the ID of a directory role in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDirectoryRoleMember](Get-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)

