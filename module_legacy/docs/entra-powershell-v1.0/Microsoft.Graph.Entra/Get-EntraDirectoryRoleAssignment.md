---
title: Get-EntraDirectoryRoleAssignment
description: This article provides details on the Get-EntraDirectoryRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDirectoryRoleAssignment

schema: 2.0.0
---

# Get-EntraDirectoryRoleAssignment

## Synopsis

Get a Microsoft Entra ID roleAssignment.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDirectoryRoleAssignment
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetValue

```powershell
Get-EntraDirectoryRoleAssignment
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDirectoryRoleAssignment
 -UnifiedRoleAssignmentId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDirectoryRoleAssignment` cmdlet gets information about role assignments in Microsoft Entra ID. To get a role assignment, specify the `UnifiedRoleAssignmentId` parameter. Specify the `SearchString` or `Filter` parameter to find a particular role assignment.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with one of the following permissions:

- microsoft.directory/roleAssignments/standard/read (least privileged)
- microsoft.directory/roleAssignments/allProperties/read
- microsoft.directory/roleAssignments/allProperties/allTasks

The least privileged roles for this operation, from least to most privileged, are:

- Directory Readers
- Global Reader
- Privileged Role Administrator

## Examples

### Example 1: Get role assignments

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444          aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
11112222-bbbb-3333-cccc-4444dddd5555          bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
22223333-cccc-4444-dddd-5555eeee6666          cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
33334444-dddd-5555-eeee-6666ffff7777          dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
44445555-eeee-6666-ffff-7777aaaa8888          eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
```

This command gets the role assignments in Microsoft Entra ID.  

### Example 2: Get role assignments using 'All' parameter

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment -All 
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444          aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
11112222-bbbb-3333-cccc-4444dddd5555          bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
22223333-cccc-4444-dddd-5555eeee6666          cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
33334444-dddd-5555-eeee-6666ffff7777          dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
44445555-eeee-6666-ffff-7777aaaa8888          eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                 
```

This command gets all the role assignments in Microsoft Entra ID.  

### Example 3: Get role assignments by Id

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId '00001111-aaaa-2222-bbbb-3333cccc4444'
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                       
```

This command gets the role assignments using specified roleAssignment Id.

- `UnifiedRoleAssignmentId` parameter specifies the roleAssignment object ID.

### Example 4: Get role assignments filter by principalId

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment -Filter "principalId eq 'aaaaaaaa-bbbb-cccc-1111-222222222222'"
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
11112222-bbbb-3333-cccc-4444dddd5555           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /        
```

This command gets the role assignments containing the specified principalId.  

### Example 5: Get role assignments filter by roleDefinitionId

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment -Filter "roleDefinitionId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'"
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444          aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
11112222-bbbb-3333-cccc-4444dddd5555          bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
22223333-cccc-4444-dddd-5555eeee6666          cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
33334444-dddd-5555-eeee-6666ffff7777          dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
44445555-eeee-6666-ffff-7777aaaa8888          eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /            
```

This command gets the role assignments containing the specified roleDefinitionId.  

### Example 6: Get top two role assignments

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleAssignment -Top 2
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
00001111-aaaa-2222-bbbb-3333cccc4444          aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
11112222-bbbb-3333-cccc-4444dddd5555           bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /   
```

This command gets top two role assignments.

## Parameters

### -UnifiedRoleAssignmentId

The unique identifier of a Microsoft Entra ID roleAssignment object.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

The maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The OData v4.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment

## Notes

`Get-EntraRoleAssignment` is an alias for `Get-EntraDirectoryRoleAssignment`.

## Related Links

[New-EntraDirectoryRoleAssignment](New-EntraDirectoryRoleAssignment.md)

[Remove-EntraDirectoryRoleAssignment](Remove-EntraDirectoryRoleAssignment.md)
