---
description: This article provides details on the Remove-EntraApplicationOwner command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationOwner
schema: 2.0.0
title: Remove-EntraApplicationOwner
---

# Remove-EntraApplicationOwner

## SYNOPSIS

Removes an owner from an application.

## SYNTAX

```powershell
Remove-EntraApplicationOwner
 -OwnerId <String>
 -ApplicationId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraApplicationOwner` cmdlet removes an owner from an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$owner = Get-EntraApplicationOwner -ApplicationId $application.Id | Where-Object {$_.userPrincipalName -eq 'SawyerM@contoso.com'}
Remove-EntraApplicationOwner -ApplicationId $application.Id -OwnerId $owner.Id
```

This example removes the specified owner from the specified application. You can use the command `Get-EntraApplication` to get application Id.

- `-ApplicationId` parameter specifies the the unique identifier of a application.
- `-OwnerId` parameter specifies the ID of the owner.

## PARAMETERS

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

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

Specifies the ID of the owner.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, -`InformationVariable`, `-OutVariable`, -`OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)
