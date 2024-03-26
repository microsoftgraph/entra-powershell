---
title: Remove-EntraServiceAppRoleAssignment.
description: This article provides details on the Remove-EntraServiceAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraServiceAppRoleAssignment

## SYNOPSIS
Removes a service principal application role assignment.

## SYNTAX

```
Remove-EntraServiceAppRoleAssignment 
-AppRoleAssignmentId <String> 
-ObjectId <String>
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraServiceAppRoleAssignment cmdlet removes a service principal application role assignment in Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes a service principal application role assignment
```powershell
PS C:\>  Remove-AzureADServiceAppRoleAssignment -ObjectId cc7fcc82-ac1b-4785-af47-2ca3b7052886  -AppRoleAssignmentId u7EFjxI8P061FwF7a-d81zXC6iDJ4llOsgQr_6xUFLk
```

This example demonstrates how to remove a service principal application role assignment in Microsoft Entra ID.

## PARAMETERS

### -AppRoleAssignmentId
Specifies the ID of the application role assignment.

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

### -ObjectId
Specifies the ID of a service principal in Microsoft Entra ID.

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

[Get-EntraServiceAppRoleAssignment](Get-EntraServiceAppRoleAssignment.md)

[New-EntraServiceAppRoleAssignment](New-EntraServiceAppRoleAssignment.md)

