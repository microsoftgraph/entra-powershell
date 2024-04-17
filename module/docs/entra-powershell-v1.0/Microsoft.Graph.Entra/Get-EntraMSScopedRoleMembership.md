---
title: Get-EntraMSScopedRoleMembership
description: This article provides details on the Get-EntraMSScopedRoleMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSScopedRoleMembership

## SYNOPSIS
Gets a scoped role membership from an administrative unit.

## SYNTAX

```powershell
Get-EntraMSScopedRoleMembership 
 -Id <String> 
 [-ScopedRoleMembershipId <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSScopedRoleMembership cmdlet gets a scoped role membership from an administrative unit in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get Scoped Role Administrator
```powershell
PS C:\>Get-EntraMSScopedRoleMembership -Id "526b7173-5a6e-49dc-88ec-b677a9093709" -ScopedRoleMembershipId "356b7173-5a6e-49dc-88ec-b677a9093709"
```

```output
AdministrativeUnitId                 Id                                                                RoleId
--------------------                 --                                                                ------
526b7173-5a6e-49dc-88ec-b677a9093709 BMYgih8pw0y20CQerx3BhEAwHXd98V5Gi-vwYVZQpAouYj-NPIZuQYv0G7SehpIUU 356b7173-5a6e-49dc-88ec-b...
```

This command gets the scoped role membership from a specified administrative unit with specified scoped role membership ID.

### Example 2: List scoped administrators for administrative unit.
```powershell
PS C:\>Get-EntraMSScopedRoleMembership -Id "526b7173-5a6e-49dc-88ec-b677a9093709"
```

```output
AdministrativeUnitId                 Id                                                                RoleId
--------------------                 --                                                                ------
526b7173-5a6e-49dc-88ec-b677a9093709 BMYgih8pw0y20CQerx3BhEAwHXd98V5Gi-vwYVZQpAouYj-NPIZuQYv0G7SehpIUU 8a20c604-291f-4cc3-b6d0-2...
526b7173-5a6e-49dc-88ec-b677a9093709 BMYgih8pw0y20CQerx3BhEAwHXd98V5Gi-vwYVZQpApdfqODbZQvQbS2rHEuDlWmU 8a20c604-291f-4cc3-b6d0-2...
```

This command gets the list of scoped role membership from a specified administrative unit.

## PARAMETERS

### -Id
Specifies the ID of an object.

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

### -ScopedRoleMembershipId
Specifies the ID of a scoped role membership.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

[Add-EntraMSScopedRoleMembership](Add-EntraMSScopedRoleMembership.md)

[Remove-EntraMSScopedRoleMembership](Remove-EntraMSScopedRoleMembership.md)

