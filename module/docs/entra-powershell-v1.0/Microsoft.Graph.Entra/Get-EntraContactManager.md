---
Title: Get-EntraContactManager
Description: This article provides details on the Get-EntraContactManager command.

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

# Get-EntraContactManager

## Synopsis

Gets the manager of a contact.

## Syntax

```powershell
Get-EntraContactManager 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraContactManager` cmdlet gets the manager of a contact in Microsoft Entra ID.

## Examples

### Example 1: Get the manager of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraContact -Top 1
Get-EntraContactManager -ObjectId $Contact.ObjectId
```

The example demonstrates how to retrieve the manager of a contact.

## Parameters

### -ObjectId

Specifies the ID of a contact in Microsoft Entra ID.

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

[Get-EntraContact](Get-EntraContact.md)
