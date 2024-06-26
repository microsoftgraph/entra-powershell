---
Title: Remove-EntraUserAppRoleAssignment.
Description: This article provides details on the Remove-EntraUserAppRoleAssignment command.

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

# Remove-EntraUserAppRoleAssignment

## Synopsis

Removes a user application role assignment.

## Syntax

```powershell
Remove-EntraUserAppRoleAssignment
 -AppRoleAssignmentId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The Remove-EntraUserAppRoleAssignment cmdlet removes a user application role assignment in Microsoft Entra ID.

## Examples

### Example 1

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'

$RemoveAppRoleParams = @{
    ObjectId              = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    AppRoleAssignmentId   = 'C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w'
}

Remove-EntraUserAppRoleAssignment @RemoveAppRoleParams
```

This example demonstrates how to Remove the user app role assignment in Microsoft Entra ID.

## Parameters

### -AppRoleAssignmentId

Specifies the ID of an application role assignment.

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

### -ObjectId

Specifies the ID (as a User Principal Name or ObjectId) of a user in Microsoft Entra ID.

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

[Get-EntraUserAppRoleAssignment](Get-EntraUserAppRoleAssignment.md)

[New-EntraUserAppRoleAssignment](New-EntraUserAppRoleAssignment.md)
