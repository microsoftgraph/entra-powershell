---
title: Get-EntraBetaMSPrivilegedRoleAssignment.
description: This article provides details on the Get-EntraBetaMSPrivilegedRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSPrivilegedRoleAssignment

## SYNOPSIS
Get role assignments for a specific provider and resource.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSPrivilegedRoleAssignment 
 -ResourceId <String>
 -ProviderId <String>
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSPrivilegedRoleAssignment 
 -Id <String> 
 -ResourceId <String> 
 -ProviderId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSPrivilegedRoleAssignment cmdlet gets role assignments for a specific provider and resource.

## EXAMPLES

### Example 1: Get a roll assignment by ProviderId and ResourceId
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId AzureResources -ResourceId 3f5887ed-dd6e-4821-8bde-c813ec508cf9
```

This command gets all role assignments for a specific provider and resource.

### Example 2: Get a roll assignment by ProviderId, ResourceId and Id
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId aadRoles -ResourceId d5aec55f-2d12-4442-8d2f-ccca95d4390e -Id lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1

externalId                     lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1
resourceId                     d5aec55f-2d12-4442-8d2f-ccca95d4390e
startDateTime
status                         Accepted
linkedEligibleRoleAssignmentId
@odata.context                 https://graph.microsoft.com/beta/$metadata#governanceRoleAssignments/$entity
endDateTime
id                             lAPpYvVpN0KRkAEhdxReEA91U-qK4kVGsXSJYY7dA0o-1
memberType                     Direct
assignmentState                Active
subjectId                      ea53750f-e28a-4645-b174-89618edd034a
roleDefinitionId               62e90394-69f5-4237-9190-012177145e10
```

This command gets a role assignment for a specific provider and resource.

### Example 3: Get five roll assignment 
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId aadRoles -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Top 5
```

This command gets top five role assignments for a specific provider and resource.

### Example 4: Get a roll assignment by SubjectId 
```
PS C:\>  Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId aadRoles -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Filter  "subjectId eq '7358288b-90fc-44fa-ad96-2a185f8ed9d2'"

externalId                     3ywjKSOT_UKt4h0JevPk3osoWHP8kPpErZYqGF-O2dI-1
resourceId                     d5aec55f-2d12-4442-8d2f-ccca95d4390e
startDateTime
status                         Accepted
linkedEligibleRoleAssignmentId
endDateTime
id                             3ywjKSOT_UKt4h0JevPk3osoWHP8kPpErZYqGF-O2dI-1
memberType                     Direct
assignmentState                Active
subjectId                      7358288b-90fc-44fa-ad96-2a185f8ed9d2
roleDefinitionId               29232cdf-9323-42fd-ade2-1d097af3e4de
```

This command gets the specified role assignments.

### Example 5: Get a roll assignment by roll defination Id
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId aadRoles -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Filter "startswith(roleDefinitionId,'7593')"

externalId                     MUCTdX5sWkGZ10jb1J6HXqo5bZms_ZdNqj3IH7RzYqw-1
resourceId                     d5aec55f-2d12-4442-8d2f-ccca95d4390e
startDateTime
status                         Accepted
linkedEligibleRoleAssignmentId
endDateTime
id                             MUCTdX5sWkGZ10jb1J6HXqo5bZms_ZdNqj3IH7RzYqw-1
memberType                     Direct
assignmentState                Active
subjectId                      996d39aa-fdac-4d97-aa3d-c81fb47362ac
roleDefinitionId               75934031-6c7e-415a-99d7-48dbd49e875e
```

This command gets all role assignments whos roll defination Id starts with '7593'.

## PARAMETERS

### -Filter
The Odata filter

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

### -ProviderId
The unique identifier of the specific provider

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

### -ResourceId
The unique identifier of the specific resource

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

### -Id
The unique identifier of the specific role assignment

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

### -Top
The top count

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
### System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
