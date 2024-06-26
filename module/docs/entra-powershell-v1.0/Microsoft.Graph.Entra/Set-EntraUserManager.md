---
Title: Set-EntraUserManager.
Description: This article provides details on the Set-EntraUserManager command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Set-EntraUserManager

## Synopsis

Updates a user's manager.

## Syntax

```powershell
Set-EntraUserManager 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description

The Set-EntraUserManager cmdlet update the manager for a user in Microsoft Entra ID.

## Examples

### Example 1: Update a user's manager

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUserManager -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -RefObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

This example demonstrates how to set the manager, with ID `eeeeeeee-4444-5555-6666-ffffffffffff` for the user with the ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

## Parameters

### -ObjectId

Specifies the ID (as a UserPrincipalName or ObjectId) of a user in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

[Get-EntraUserManager](Get-EntraUserManager.md)

[Remove-EntraUserManager](Remove-EntraUserManager.md)
