---
title: Set-EntraApplicationVerifiedPublisher
description: This article provides details on the Set-EntraApplicationVerifiedPublisher command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraApplicationVerifiedPublisher

schema: 2.0.0
---

# Set-EntraApplicationVerifiedPublisher

## Synopsis

Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Syntax

```powershell
Set-EntraApplicationVerifiedPublisher
 -AppObjectId <String>
 -SetVerifiedPublisherRequest <SetVerifiedPublisherRequest>
 [<CommonParameters>]
```

## Description

Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Examples

### Example 1: Set the verified publisher of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$app = Get-EntraApplication -Filter "DisplayName eq '<application-display-name>'"
$appObjId = $app.ObjectId
$mpnId =  '0433167'
$req =  @{verifiedPublisherId = $mpnId}
$params = @{
     AppObjectId = $appObjId
     SetVerifiedPublisherRequest = $req
}
Set-EntraApplicationVerifiedPublisher @params
```

This command sets the verified publisher of an application.

The Microsoft Partner Network ID (MPNID) of the verified publisher can be obtained from the publisher's Partner Center account.

- `-AppObjectId` parameter specifies the unique identifier of a Microsoft Entra ID Application.
- `-SetVerifiedPublisherRequest` parameter specifies the request body object containing the verifiedPublisherId property with it's the MPNID value.

## Parameters

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

## Inputs

### String

## Outputs

## Notes

## Related Links

[Remove-EntraApplicationVerifiedPublisher](Remove-EntraApplicationVerifiedPublisher.md)
