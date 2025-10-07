---
author: msewaweru
description: This article provides details on the Set-EntraBetaApplicationVerifiedPublisher command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Set-EntraBetaApplicationVerifiedPublisher
schema: 2.0.0
title: Set-EntraBetaApplicationVerifiedPublisher
---

# Set-EntraBetaApplicationVerifiedPublisher

## SYNOPSIS

Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## SYNTAX

```powershell
Set-EntraBetaApplicationVerifiedPublisher
 -SetVerifiedPublisherRequest <SetVerifiedPublisherRequest>
 -AppObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## EXAMPLES

### Example 1: Set the verified publisher of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$mpnId =  '0433167'
$req =  @{verifiedPublisherId = $mpnId}
Set-EntraBetaApplicationVerifiedPublisher -AppObjectId $application.Id -SetVerifiedPublisherRequest $req
```

This command sets the verified publisher of an application.

The Microsoft Partner Network ID (MPNID) of the verified publisher can be obtained from the publisher's Partner Center account.

- `-AppObjectId` parameter specifies the unique identifier of a Microsoft Entra ID Application.
- `-SetVerifiedPublisherRequest` parameter specifies the request body object containing the verifiedPublisherId property with it's the MPNID value.

## PARAMETERS

### -AppObjectId

The unique identifier of a Microsoft Entra ID Application object.

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

### -SetVerifiedPublisherRequest

A request body object containing the verifiedPublisherId property it's the MPNID value.

```yaml
Type: SetVerifiedPublisherRequest
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

## INPUTS

### String

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaApplicationVerifiedPublisher](Remove-EntraBetaApplicationVerifiedPublisher.md)
