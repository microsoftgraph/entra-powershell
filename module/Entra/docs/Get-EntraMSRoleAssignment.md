---
title: Get-EntraMSRoleAssignment
description: This article provides details on the Get-EntraMSRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSRoleAssignment

## SYNOPSIS
Get a Microsoft Entra ID roleAssignment.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraMSRoleAssignment 
    [-Top <Int32>] 
    [-All <Boolean>] 
    [-Filter <String>] 
    [<CommonParameters>]
```

### GetVague
```powershell
Get-EntraMSRoleAssignment 
    [-SearchString <String>] 
    [-All <Boolean>] 
    [<CommonParameters>]
```

### GetById
```powershell
Get-EntraMSRoleAssignment 
    -Id <String> 
    [-All <Boolean>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraMSRoleAssignment** cmdlet gets information about role assignments in Microsoft Entra ID. To get a role assignment, specify the Id parameter. Specify the SearchString or Filter parameter to find a particular role assignment.

## EXAMPLES

### Example 1: Get role assignments
```powershell
PS C:\> Get-EntraMSRoleAssignment
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
lAPpYvVpN0KRkAEhdxReEMInXVSgJ8VDiO9uyQzGxBA-1 545d27c2-27a0-43c5-88ef-6ec90cc6c410 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReECkf15ESHNtAil5w2vuw328-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEKo5bZms_ZdNqj3IH7RzYqw-1 996d39aa-fdac-4d97-aa3d-c81fb47362ac 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1 ea53750f-e28a-4645-b174-89618edd034a 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEAEK5evQH41LuuWVQ4sJ7xQ-1 ebe50a01-1fd0-4b8d-bae5-95438b09ef14 62e90394-69f5-4237-9190-012177145e10 /
```

This command gets the role assignments in Microsoft Entra ID.  

### Example 2: Get role assignments using 'All' parameter
```powershell
PS C:\> Get-EntraMSRoleAssignment -All $true
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
lAPpYvVpN0KRkAEhdxReEMInXVSgJ8VDiO9uyQzGxBA-1 545d27c2-27a0-43c5-88ef-6ec90cc6c410 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReECkf15ESHNtAil5w2vuw328-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEKo5bZms_ZdNqj3IH7RzYqw-1 996d39aa-fdac-4d97-aa3d-c81fb47362ac 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1 ea53750f-e28a-4645-b174-89618edd034a 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEAEK5evQH41LuuWVQ4sJ7xQ-1 ebe50a01-1fd0-4b8d-bae5-95438b09ef14 62e90394-69f5-4237-9190-012177145e10 /
```

This command gets all the role assignments in Microsoft Entra ID.  

### Example 3: Get role assignments filter by principalId
```powershell
PS C:\> Get-EntraMSRoleAssignment -Filter "principalId eq '91d71f29-1c12-40db-8a5e-70dafbb0df6f'"
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
lAPpYvVpN0KRkAEhdxReEMInXVSgJ8VDiO9uyQzGxBA-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReECkf15ESHNtAil5w2vuw328-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
```

This command gets the role assignments containing the specified principalId.  

### Example 4: Get role assignments filter by roleDefinitionId
```powershell
PS C:\> Get-EntraMSRoleAssignment -Filter "roleDefinitionId eq '91d71f29-1c12-40db-8a5e-70dafbb0df6f'"
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
lAPpYvVpN0KRkAEhdxReEMInXVSgJ8VDiO9uyQzGxBA-1 545d27c2-27a0-43c5-88ef-6ec90cc6c410 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReECkf15ESHNtAil5w2vuw328-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEKo5bZms_ZdNqj3IH7RzYqw-1 996d39aa-fdac-4d97-aa3d-c81fb47362ac 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1 ea53750f-e28a-4645-b174-89618edd034a 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEAEK5evQH41LuuWVQ4sJ7xQ-1 ebe50a01-1fd0-4b8d-bae5-95438b09ef14 62e90394-69f5-4237-9190-012177145e10 /
```

This command gets the role assignments containing the specified roleDefinitionId.  

### Example 5: Get top two role assignments
```powershell
PS C:\> Get-EntraMSRoleAssignment -Top 2
```

```output
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScopeId
--                                            -----------                          ----------------                     ---------------- ----------
lAPpYvVpN0KRkAEhdxReEMInXVSgJ8VDiO9uyQzGxBA-1 545d27c2-27a0-43c5-88ef-6ec90cc6c410 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReECkf15ESHNtAil5w2vuw328-1 91d71f29-1c12-40db-8a5e-70dafbb0df6f 62e90394-69f5-4237-9190-012177145e10 /
```

This command gets top two role assignments.

## PARAMETERS

### -Id
The unique identifier of a Microsoft Entra ID roleAssignment object.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All
Boolean to express that return all results from the server for the specific query

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top
The maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
The oData v3.0 filter statement. 
Controls which objects are returned.

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString
Specifies a search string.

```yaml
Type: String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
### bool?
### int?
## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment
## NOTES

## RELATED LINKS
