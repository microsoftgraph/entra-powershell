---
title: New-EntraMSRoleAssignment
description: This article provides details on the New-EntraMSRoleAssignment command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSRoleAssignment

## SYNOPSIS
Create a new Microsoft Entra ID roleAssignment.

## SYNTAX

```powershell
New-EntraMSRoleAssignment 
 -PrincipalId <String>     
 -RoleDefinitionId <String>
 [-DirectoryScopeId <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraMSRoleAssignment cmdlet creates a new Microsoft Entra ID role assignment.

## EXAMPLES

### Example 1: Create a new Microsoft Entra ID role assignment
```powershell
PS C:\> New-EntraMSRoleAssignment -RoleDefinitionId 54d418b2-4cc0-47ee-9b39-e8f84ed8e073 -PrincipalId 02ed943d-6eca-4f99-83d6-e6fbf9dc63ae -DirectoryScopeId '/'
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1 02ed943d-6eca-4f99-83d6-e6fbf9dc63ae 54d418b2-4cc0-47ee-9b39-e8f84ed8e073 /
```

This command creates a new role assignment.

## PARAMETERS

### -DirectoryScopeId
Specifies the scope for the role assignment.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrincipalId
Specifies the principal for role assignment.

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

### -RoleDefinitionId
Specifies the role definition for role assignment.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment
## NOTES

## RELATED LINKS
