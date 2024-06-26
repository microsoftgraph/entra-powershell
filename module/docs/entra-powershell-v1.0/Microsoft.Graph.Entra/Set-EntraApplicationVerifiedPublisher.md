---
title: Set-EntraApplicationVerifiedPublisher
description: This article provides details on the Set-EntraApplicationVerifiedPublisher command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraApplicationVerifiedPublisher

## Synopsis
sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Syntax

```powershell
Set-EntraApplicationVerifiedPublisher 
 -AppObjectId <String>
 -SetVerifiedPublisherRequest <SetVerifiedPublisherRequest> 
 [<CommonParameters>]
```

## Description
sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Examples

### Example 1: Set the verified publisher of an application.
```powershell
PS C:\> $appObjId = 'ad6c71a5-e48f-4320-bb59-92642a2d8d9f'
PS C:\> $mpnId =  '0433167'
PS C:\> $req =  @{verifiedPublisherId=$mpnId}
PS C:\> Set-EntraApplicationVerifiedPublisher -AppObjectId $appObjId -SetVerifiedPublisherRequest $req
```

This command sets the verified publisher of an application.

## Parameters

### -AppObjectId
The unique identifier of a Microsoft Entra ID Application object.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String
### String
## Outputs

## Notes

## Related Links

[Remove-EntraApplicationVerifiedPublisher](Remove-EntraApplicationVerifiedPublisher.md)

