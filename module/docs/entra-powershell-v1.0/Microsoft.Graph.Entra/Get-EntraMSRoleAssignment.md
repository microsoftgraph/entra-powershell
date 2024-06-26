---
title: Get-EntraMSRoleAssignment
description: This article provides details on the Get-EntraMSRoleAssignment command.

ms.service: entra
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

# Get-EntraMSRoleAssignment

## SYNOPSIS

Get a Microsoft Entra ID roleAssignment.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraMSRoleAssignment 
 [-Top <Int32>] 
 [-All] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetValue

```powershell
Get-EntraMSRoleAssignment 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraMSRoleAssignment 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraMSRoleAssignment` cmdlet gets information about role assignments in Microsoft Entra ID. To get a role assignment, specify the Id parameter. Specify the SearchString or Filter parameter to find a particular role assignment.

## EXAMPLES

### Example 1: Get role assignments

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraMSRoleAssignment
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y           cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a           dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
J5kL6mN7oP8qR9sT0uV1wX2yZ3aB4c           eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
```

This command gets the role assignments in Microsoft Entra ID.  

### Example 2: Get role assignments using 'All' parameter

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraMSRoleAssignment -All 
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y           cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a           dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
J5kL6mN7oP8qR9sT0uV1wX2yZ3aB4c           eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
```

This command gets all the role assignments in Microsoft Entra ID.  

### Example 3: Get role assignments filter by principalId

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraMSRoleAssignment -Filter "principalId eq 'aaaaaaaa-bbbb-cccc-1111-222222222222'"
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /        
```

This command gets the role assignments containing the specified principalId.  

### Example 4: Get role assignments filter by roleDefinitionId

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraMSRoleAssignment -Filter "roleDefinitionId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'"
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           bbbbbbbb-cccc-dddd-2222-333333333333  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y           cccccccc-dddd-eeee-3333-444444444444  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a           dddddddd-eeee-ffff-4444-555555555555  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
J5kL6mN7oP8qR9sT0uV1wX2yZ3aB4c           eeeeeeee-ffff-aaaa-5555-666666666666  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /            
```

This command gets the role assignments containing the specified roleDefinitionId.  

### Example 5: Get top two role assignments

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraMSRoleAssignment -Top 2
```

```Output
Id                                      PrincipalId                           RoleDefinitionId                    DirectoryScopeId AppScopeId
--                                      -----------                           ----------------                    ---------------- ----------
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /                
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           aaaaaaaa-bbbb-cccc-1111-222222222222  a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  /    
```

This command gets top two role assignments.

## PARAMETERS

### -Id

The unique identifier of a Microsoft Entra ID roleAssignment object.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

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

The oData v3.0 filter statement.
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

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetValue
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string

## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment

## NOTES

## RELATED LINKS

[New-EntraMSRoleAssignment](New-EntraMSRoleAssignment.md)

[Remove-EntraMSRoleAssignment](Remove-EntraMSRoleAssignment.md)
