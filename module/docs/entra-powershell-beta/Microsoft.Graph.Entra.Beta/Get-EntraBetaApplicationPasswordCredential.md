---
title: Get-EntraBetaApplicationPasswordCredential
description: This article provides details on the Get-EntraBetaApplicationPasswordCredential command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationPasswordCredential

## Synopsis

Gets the password credential for an application.

## Syntax

```powershell
Get-EntraBetaApplicationPasswordCredential 
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationPasswordCredential` cmdlet gets the password credentials for a Microsoft Entra ID application.

## Examples

### Example 1: Get password credential for specified application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
New-EntraBetaApplicationPasswordCredential -ObjectId aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

```output
CustomKeyIdentifier  DisplayName EndDateTime           Hint KeyId                                SecretText StartDateTime
-------------------  ----------- -----------           ---- -----                                ---------- -------------
{116, 101, 115, 116}             11/24/2024 6:28:39 AM 123  bbbbbbbb-1111-2222-3333-cccccccccccc            11/24/2023 6:28:39 AM
```

This command gets the password credential for specified application.

## Parameters

### -ObjectId

The objectID of the application for which to get the password credential.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
