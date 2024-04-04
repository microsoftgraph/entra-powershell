---
title: Get-EntraApplicationPasswordCredential
description: This article provides details on the Get-EntraApplicationPasswordCredential command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationPasswordCredential

## SYNOPSIS
Gets the password credential for an application.

## SYNTAX

```powershell
Get-EntraApplicationPasswordCredential 
    -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraApplicationPasswordCredential** cmdlet gets the password credentials for a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get password credential for specified application.
```powershell
PS C:\>New-EntraApplicationPasswordCredential -ObjectId 3ddd22e7-a150-4bb3-b100-e410dea1cb84
```

```output
CustomKeyIdentifier  DisplayName EndDateTime           Hint KeyId                                SecretText StartDateTime
-------------------  ----------- -----------           ---- -----                                ---------- -------------
{116, 101, 115, 116}             11/24/2024 6:28:39 AM 123  292e9b65-45db-4fe1-9362-da69c64d8649            11/24/2023 6:28:39 AM
```

This command gets the password credential for specified application.

## PARAMETERS

### -ObjectId
The objectID of the application for which to get the password credential.

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
