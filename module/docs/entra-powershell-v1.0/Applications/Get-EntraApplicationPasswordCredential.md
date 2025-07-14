---
description: This article provides details on the Get-EntraApplicationPasswordCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraApplicationPasswordCredential
schema: 2.0.0
title: Get-EntraApplicationPasswordCredential
---

# Get-EntraApplicationPasswordCredential

## SYNOPSIS

Gets the password credential for an application.

## SYNTAX

```powershell
Get-EntraApplicationPasswordCredential
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraApplicationPasswordCredential` cmdlet receives the password credentials for a Microsoft Entra ID application. Specify `ApplicationId` parameter to cmdlet receives the password credentials.

## EXAMPLES

### Example 1: Get password credential for specified application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraApplicationPasswordCredential -ApplicationId $application.Id
```

```Output
CustomKeyIdentifier  DisplayName EndDateTime         Hint KeyId                                SecretText StartDateTime
-------------------  ----------- -----------         ---- -----                                ---------- -------------
{100, 101, 109, 111} demo        26/07/2025 10:34:40 Ap6  bbbbbbbb-1111-2222-3333-cccccccccccc             26/07/2024 10:34:40
```

This example shows how to retrieve the password credential for specified application.

- `-ApplicationId` specifies the ID of an application object in Microsoft Entra ID.

## PARAMETERS

### -ApplicationId

The ApplicationId of the application for which to get the password credential. Use `Get-EntraApplication` for more details.

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplication](Get-EntraApplication.md)
