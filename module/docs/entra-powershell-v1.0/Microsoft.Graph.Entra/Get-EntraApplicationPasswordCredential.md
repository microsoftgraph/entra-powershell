---
Title: Get-EntraApplicationPasswordCredential
Description: This article provides details on the Get-EntraApplicationPasswordCredential command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraApplicationPasswordCredential

## Synopsis

Gets the password credential for an application.

## Syntax

```powershell
Get-EntraApplicationPasswordCredential 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationPasswordCredential` cmdlet gets the password credentials for a Microsoft Entra ID application.

## Examples

### Example 1: Get password credential for specified application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
New-EntraApplicationPasswordCredential -ObjectId aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
