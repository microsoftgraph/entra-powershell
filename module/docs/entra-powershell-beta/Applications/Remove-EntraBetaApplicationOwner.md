---
description: This article provides details on the Remove-EntraBetaApplicationOwner command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationOwner
schema: 2.0.0
title: Remove-EntraBetaApplicationOwner
---

# Remove-EntraBetaApplicationOwner

## SYNOPSIS

Removes an owner from an application.

## SYNTAX

```powershell
Remove-EntraBetaApplicationOwner
 -OwnerId <String>
 -ApplicationId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplicationOwner` cmdlet removes an owner from an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$owner = Get-EntraBetaApplicationOwner -ApplicationId $application.Id | Where-Object {$_.userPrincipalName -eq 'SawyerM@contoso.com'}
Remove-EntraBetaApplicationOwner -ApplicationId $application.Id -OwnerId $owner.Id
```

This example removes the specified owner from the specified application. You can use the command `Get-EntraBetaApplication` to get application Id.

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

[Add-EntraBetaApplicationOwner](Add-EntraBetaApplicationOwner.md)

[Get-EntraBetaApplicationOwner](Get-EntraBetaApplicationOwner.md)
