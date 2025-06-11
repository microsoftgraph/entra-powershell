---
title: Add-EntraServicePrincipalOwner
description: This article provides details on the Add-EntraServicePrincipalOwner command.

ms.topic: reference
ms.date: 02/08/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Entra.Applications-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraServicePrincipalOwner

schema: 2.0.0
---

# Add-EntraServicePrincipalOwner

## Synopsis

Add an owner (user or service principal) to a service principal.

## Syntax

### ByServicePrincipalIdAndOwnerId

```powershell
Add-EntraServicePrincipalOwner
 -ServicePrincipalId <String>
 -OwnerId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraServicePrincipalOwner` cmdlet adds an owner to a service principal in Microsoft Entra ID. The owner can be a user, the service principal itself, or another service principal.

## Examples

### Example 1: Add a user as an owner to a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$owner = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -OwnerId $owner.Id
```

This example demonstrates how to add an owner to a service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.
- `-OwnerId` parameter specifies the unique ID of the owner, which can be a user, the service principal itself, or another service principal.

### Example 2: Add a service principal as an owner

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
$owner = Get-EntraServicePrincipal -Filter "displayName eq 'IT Department'"
Add-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -OwnerId $owner.Id
```

This example demonstrates how to add an owner to a service principal.

- `-ServicePrincipalId` parameter specifies the service principal ID.
- `-OwnerId` parameter specifies the unique ID of the owner, which can be a user, the service principal itself, or another service principal.

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

### -OwnerId

Specifies the unique ID of the owner, which can be a user, the service principal itself, or another service principal.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

[Get-EntraUser](../Users/Get-EntraUser.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)
