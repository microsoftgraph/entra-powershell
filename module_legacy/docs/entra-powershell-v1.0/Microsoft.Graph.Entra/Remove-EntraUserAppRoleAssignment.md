---
title: Remove-EntraUserAppRoleAssignment
description: This article provides details on the Remove-EntraUserAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraUserAppRoleAssignment

schema: 2.0.0
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

The `Remove-EntraUserAppRoleAssignment` cmdlet removes a user application role assignment in Microsoft Entra ID.

## Examples

### Example 1: Remove user app role assignment

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$RemoveAppRoleParams = @{
    ObjectId              = 'SawyerM@Contoso.com'
    AppRoleAssignmentId   = 'C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w'
}
Remove-EntraUserAppRoleAssignment @RemoveAppRoleParams
```

This example demonstrates how to Remove the user app role assignment in Microsoft Entra ID.

- `-ObjectId` parameter specifies the user ID.
- `-AppRoleAssignmentId` parameter specifies the application role assignment ID.

Use the `Get-EntraUserAppRoleAssignment` cmdlet to get `AppRoleAssignmentId` details.

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

Specifies the ID (as a UserPrincipleName or ObjectId) of a user in Microsoft Entra ID.

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
