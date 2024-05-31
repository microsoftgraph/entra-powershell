---
title: Add-EntraAdministrativeUnitMember
description: This article provides details on the Add-EntraAdministrativeUnitMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 05/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraAdministrativeUnitMember

## SYNOPSIS
Adds an administrative unit member.

## SYNTAX

```powershell
Add-EntraAdministrativeUnitMember 
 -RefObjectId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraAdministrativeUnitMember cmdlet adds a Microsoft Entra ID administrative unit member.

## EXAMPLES

### Example 1: Add an administrative unit member
```powershell
PS C:\> Add-EntraAdministrativeUnitMember -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ObjectId "dddddddd-1111-2222-3333-cccccccccccc"
```
This example demonstrated how to add administrative unit member.
## PARAMETERS

### -ObjectId
Specifies the ID of a Microsoft Entra ID administrative unit.

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
Specifies the unique ID of the specific Microsoft Entra ID object that assign as owner/manager/member.

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

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)