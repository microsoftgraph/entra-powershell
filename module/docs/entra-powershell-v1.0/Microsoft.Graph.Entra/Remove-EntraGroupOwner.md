---
Title: Remove-EntraGroupOwner
Description: This article provides details on the Remove-EntraGroupOwner command.

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

# Remove-EntraGroupOwner

## Synopsis

Removes an owner from a group.

## Syntax

```powershell
Remove-EntraGroupOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Remove-EntraGroupOwner cmdlet removes an owner from a group in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Remove-EntraGroupOwner -ObjectId 'qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh' -OwnerId 'xxxxxxxx-8888-5555-9999-bbbbbbbbbbbb'
```

This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

ObjectID - Specifies the ID of a group in Microsoft Entra ID.  

OwnerId  - Specifies the ID of an owner.

## Parameters

### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

### -OwnerId

Specifies the ID of an owner.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)