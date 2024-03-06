---
title: New-EntraGroupAppRoleAssignment.
description: This article provides details on the New-EntraGroupAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraGroupAppRoleAssignment

## SYNOPSIS
Assign a group of users to an application role.

## SYNTAX

```
New-EntraGroupAppRoleAssignment 
 -ObjectId <String> 
 -PrincipalId <String> 
 -Id <String> 
 -ResourceId <String>
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraGroupAppRoleAssignment cmdlet assigns a group of users to an application role in Microsoft Entra ID.

## EXAMPLES

### Example 1: Assign a group of users to an application
```powershell
PS C:\> New-EntraGroupAppRoleAssignment -Id e18f0405-fdec-4ae8-a8a0-d8edb98b061f -ResourceId cc7fcc82-ac1b-4785-af47-2ca3b7052886 -ObjectId 0877c6c6-fc99-4d51-9871-8335be7cfc9d  -PrincipalId 0877c6c6-fc99-4d51-9871-8335be7cfc9d
```

This command assigns a group of users to an application role in Microsoft Entra ID.

## PARAMETERS

### -Id
Specifies the ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
Specifies how this cmdlet responds to an information event.

The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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

### -PrincipalId
Specifies the principal ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
Specifies the resource ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroupAppRoleAssignment]()

[Remove-EntraGroupAppRoleAssignment]()

[Managing applications in Microsoft Entra ID using PowerShell](https://channel9.msdn.com/Series/Azure-Active-Directory-Videos-Demos/ManageAppsAzureADPowerShell)

