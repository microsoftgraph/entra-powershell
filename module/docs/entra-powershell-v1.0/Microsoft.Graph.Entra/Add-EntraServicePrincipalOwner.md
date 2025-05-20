---
title: Add-EntraServicePrincipalOwner
description: This article provides details on the Add-EntraServicePrincipalOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraServicePrincipalOwner

schema: 2.0.0
---

# Add-EntraServicePrincipalOwner

## Synopsis

Adds an owner to a service principal.

## Syntax

```powershell
Add-EntraServicePrincipalOwner
 -ServicePrincipalId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraServicePrincipalOwner` cmdlet adds an owner to a service principal in Microsoft Entra ID.

## Examples

### Example 1: Add a user as an owner to a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$owner = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -RefObjectId $owner.Id
```

This example demonstrates how to add an owner to a service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.
- `-RefObjectId` parameter specifies the user object ID.

## Parameters

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Get-EntraServicePrincipalOwner](Get-EntraServicePrincipalOwner.md)

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)
