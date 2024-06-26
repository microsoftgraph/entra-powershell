---
title: Add-EntraServicePrincipalOwner
description: This article provides details on the Add-EntraServicePrincipalOwner command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraServicePrincipalOwner

## Synopsis

Adds an owner to a service principal.

## Syntax

```powershell
Add-EntraServicePrincipalOwner 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description

The Add-EntraServicePrincipalOwner cmdlet adds an owner to a service principal in Microsoft Entra ID.

## Examples

### Example 1: Add a user as an owner to a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
$OwnerId = (Get-EntraUser -Top 1).ObjectId
Add-EntraServicePrincipalOwner -ObjectId $ServicePrincipalId -RefObjectId -$OwnerId
```

This example demonstrates how to add an owner to a service principal.

- The first command gets the object ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet, and then stores it in the $ServicePrincipalId variable.
- The second command gets the object ID a user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet, and then stores it in the $OwnerId variable.
- The final command adds the user specified by $OwnerId an owner to a service principal specified by $ServicePrincipalId.

## Parameters

### -ObjectId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
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
Type: System.String
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

## Related LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Get-EntraServicePrincipalOwner](Get-EntraServicePrincipalOwner.md)

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)