---
title: Get-EntraBetaApplicationPasswordCredential
description: This article provides details on the Get-EntraBetaApplicationPasswordCredential command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationPasswordCredential
schema: 2.0.0
---

# Get-EntraBetaApplicationPasswordCredential

## Synopsis

Gets the password credential for an application.

## Syntax

```powershell
Get-EntraBetaApplicationPasswordCredential
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationPasswordCredential` cmdlet receives the password credentials for a Microsoft Entra ID application. Specify `ApplicationId` parameter to cmdlet receives the password credentials.

## Examples

### Example 1: Get password credential for specified application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraBetaApplicationPasswordCredential -ApplicationId $application.ObjectId
```

```Output
CustomKeyIdentifier  DisplayName EndDateTime         Hint KeyId                                SecretText StartDateTime
-------------------  ----------- -----------         ---- -----                                ---------- -------------
{100, 101, 109, 111} demo        26/07/2025 10:34:40 Ap6  bbbbbbbb-1111-2222-3333-cccccccccccc             26/07/2024 10:34:40
```

This example shows how to retrieve the password credential for specified application.

- `-ApplicationId` specifies the ID of an application object in Microsoft Entra ID.

## Parameters

### -ApplicationId

The objectID of the application for which to get the password credential. Use `Get-EntraBetaApplication` for more details.

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

### -Property

Specifies properties to be returned.

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

## Related links

[New-EntraBetaApplicationPasswordCredential](New-EntraBetaApplicationPasswordCredential.md)

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
